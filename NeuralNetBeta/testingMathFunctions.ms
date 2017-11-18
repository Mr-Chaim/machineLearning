clearListener()
targetBoxPos = $targetBox.pos
sourceBoxPos = $sourceBox.pos
guideLine = $guideLine

tltF    = mathClass.tltfFn sourceBoxPos targetBoxPos
tltPred = mathClass.tltPredFn sourceBoxPos targetBoxPos

dist = mathClass.dstFfn sourceBoxPos targetBoxPos

mathClass.posPredFn tltPred sourceBoxPos dist

mathClass.posPredFn tltF sourceBoxPos dist