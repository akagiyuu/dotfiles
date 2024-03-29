
// https://www.reddit.com/r/vscode/comments/11e66xh/i_made_neovide_alike_cursor_effect_on_vscode/

// trail color (pls match it to user cursor color)
const lineHeight = 2.2
const color = "#8B8C8B"

// imported from https://github.com/tholman/cursor-effects/blob/master/src/rainbowCursor.js
function rainbowCursor(options) {
  let canvas = options?.canvas
  let cursor = { x: 0, y: 0 }
  let particles = []
  let animationFrame
  let width,height
  let context = canvas.getContext("2d")

  function updateSize(x,y) {
    width = x
    height = y
    canvas.width = x
    canvas.height = y
  }

  // const lineHeight = options?.lineHeight || 2.2;
  const totalParticles = options?.length || 20
  const particlesColor = options.color
  let size = options?.size || 3
  let sizeY = options?.sizeY || size*2.2

  let cursorsInitted = false

  function move(x,y) {
    x = x + size/2
    y = y + size/2
    cursor.x = x
    cursor.y = y
    if (cursorsInitted === false) {
      cursorsInitted = true
      for (let i = 0; i < totalParticles; i++) {
        addParticle(x, y)
      }
    }
  }

  function Particle(x, y) {
    this.position = { x: x, y: y }
  }

  function addParticle(x, y, image) {
    particles.push(new Particle(x, y, image))
  }

  function updateParticles() {
    context.clearRect(0, 0, width, height)
    let x = cursor.x,y = cursor.y

    for (const particleIndex in particles) {
      const nextParticlePos = (particles[+particleIndex + 1] || particles[0]).position
      const particlePos = particles[+particleIndex].position

      particlePos.x = x;
      particlePos.y = y;

      x += (nextParticlePos.x - particlePos.x) * 0.42
      y += (nextParticlePos.y - particlePos.y) * 0.35
    }

    if (x >= cursor.x+2 && x <= cursor.x-2) return
    if (y >= cursor.y+2 && y <= cursor.y-2) return

    context.beginPath()
    context.lineJoin = "round"
    context.strokeStyle = particlesColor
    context.lineWidth = size

    // draw 3 lines
    let ymut = (sizeY-size)/3
    for (let yoffset=0;yoffset<=3;yoffset++) {
      let offset = yoffset*ymut
      for (const particleIndex in particles) {
        const pos = particles[particleIndex].position
        if (particleIndex == 0) {
          context.moveTo(pos.x, pos.y + offset)
        } else {
          context.lineTo(pos.x, pos.y + offset)
        }
      }
    }
    context.stroke()
  }

  function loop() {
    updateParticles();
    animationFrame = requestAnimationFrame(loop);
  }

  function destroy() {
    cancelAnimationFrame(animationFrame);
  }

  function updateCursorSize(newSize,newSizeY) {
    size = newSize
    if (newSizeY) sizeY = newSizeY
  }

  return {
    destroy: destroy,
    loop: loop,
    move: move,
    updateSize: updateSize,
    updateCursorSize: updateCursorSize
  }
}

// cursor create/remove/move event handler
// by qwreey
// (very dirty but may working)
async function createCursorHandler(handlerFunctions) {
  // Get Editor with dirty way (... due to vscode plugin api's limit)
  /** @type { Element } */
  let editor
  while (!editor) {
    await new Promise(resolve=>setTimeout(resolve, 100))
    editor = document.querySelector(".part.editor")
  }
  handlerFunctions?.onStarted(editor)

  // cursor cache
  let updateHandlers = []
  let cursorId = 0
  let lastObjects = {}

  // cursor update handler
  function createCursorUpdateHandler(target,cursorId,cursorHolder) {
    let lastX,lastY // save last position
    let update = (editorX,editorY)=>{
      // If cursor was destroyed, remove update handler
      if (!lastObjects[cursorId]) {
        updateHandlers.splice(updateHandlers.indexOf(update),1)
        return
      }

      // get cursor position
      let {left:newX,top:newY} = target.getBoundingClientRect()
      let revX = newX-editorX,revY = newY-editorY

      // if have no changes, ignore
      if (revX == lastX && revY == lastY) return
      lastX = revX;lastY = revY // update last position

      // wrong position
      if (revX<=0 || revY<=0) return

      // if it is invisible, ignore
      if (target.style.visibility != "inherit") return

      // // if moved over minimap, ignore
      // if (minimap && minimap.getBoundingClientRect().left <= newX) return

      // if cursor is not displayed on screen, ignore
      if (cursorHolder.getBoundingClientRect().left > newX) return

      // update corsor position
      handlerFunctions?.onCursorPositionUpdated(revX,revY)
      handlerFunctions?.onCursorSizeUpdated(target.clientWidth,target.clientHeight)
    }
    updateHandlers.push(update)
  }

  // handle cursor create/destroy event (using polling, due to event handlers are LAGGY)
  let lastVisibility = "hidden"
  setInterval(async ()=>{
    let now = [],count = 0
    // created
    for (const target of editor.getElementsByClassName("cursor")) {
      if (target.style.visibility != "inherit") count++
      if (target.hasAttribute("cursorId")) {
        now.push(+target.getAttribute("cursorId"))
        continue
      }
      let thisCursorId = cursorId++
      now.push(thisCursorId)
      lastObjects[thisCursorId] = target
      target.setAttribute("cursorId",thisCursorId)
      let cursorHolder = target.parentElement.parentElement.parentElement
      // let minimap = cursorHolder.parentElement.querySelector(".minimap")
      createCursorUpdateHandler(target,thisCursorId,cursorHolder)
      // console.log("DEBUG-CursorCreated",thisCursorId)
    }

    // update visible
    let visibility = count<=1 ? "visible" : "hidden"
    if (visibility != lastVisibility) {
      handlerFunctions?.onCursorVisibilityChanged(visibility)
      lastVisibility = visibility
    }

    // destroyed
    for (const id in lastObjects) {
      if (now.includes(+id)) continue
      delete lastObjects[+id]
      // let target = lastObjects[+id]
      // console.log("DEBUG-CursorRemoved",+id)
    }
  },1000)

  // read cursor position polling
  function updateLoop() {
    let {left:editorX,top:editorY} = editor.getBoundingClientRect()
    for (handler of updateHandlers) handler(editorX,editorY)
    requestAnimationFrame(updateLoop)
  }

  // handle editor view size changed event
  function updateEditorSize() {
    handlerFunctions?.onEditorSizeUpdated(editor.clientWidth,editor.clientHeight)
  }
  new ResizeObserver(updateEditorSize).observe(editor)
  updateEditorSize()

  // startup
  updateLoop()
  handlerFunctions?.onReady()
}

let cursorCanvas,rainbowCursorHandle
createCursorHandler({

  // When editor instance stared
  onStarted: (editor)=>{
    // create new canvas for make animation
    cursorCanvas = document.createElement("canvas")
    cursorCanvas.style.pointerEvents = "none"
    cursorCanvas.style.position = "absolute"
    cursorCanvas.style.top = "0px"
    cursorCanvas.style.left = "0px"
    cursorCanvas.style.zIndex = "1000"
    editor.appendChild(cursorCanvas)

    // create rainbow cursor effect
    // thanks to https://github.com/tholman/cursor-effects/blob/master/src/rainbowCursor.js
    // we can create trail effect!
    rainbowCursorHandle = rainbowCursor({
      length: 8,
      color: color,
      size: 7,
      lineHeight: lineHeight,
      canvas: cursorCanvas
    })
  },

  // ready to draw! let's call requestAnimationFrame
  onReady: ()=>{
    rainbowCursorHandle.loop()
  },

  // when cursor moved
  onCursorPositionUpdated: (x,y)=>{
    rainbowCursorHandle.move(x,y)
  },

  // when editor view size changed
  onEditorSizeUpdated: (x,y)=>{
    rainbowCursorHandle.updateSize(x,y)
  },

  // when cursor size changed (emoji, ...)
  onCursorSizeUpdated: (x,y)=>{
    rainbowCursorHandle.updateCursorSize(x,y)
    // rainbowCursorHandle.updateCursorSize(parseInt(y/lineHeight))
  },

  // when using multi cursor... just hide all
  onCursorVisibilityChanged: (visibility)=>{
    cursorCanvas.style.visibility = visibility
  }

})
