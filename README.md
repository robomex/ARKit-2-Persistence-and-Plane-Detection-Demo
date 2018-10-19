# ARKit-2-Persistence-and-Plane-Detection-Demo
This project provides:
- Visual feedback of ARKit's plane detection process, i.e. when it detects planes, where planes are detected, the detected extent of the plane, and when it refines/recalculates the detected planes
- The ability to save a session's ARWorldMap (tap 'Save') and reload that ARWorldMap in the same session (tap 'Reset') to gauge the accuracy of ARKit's persistence

This project was meant as a quick test to visualize how quickly ARKit 2.0 detects planes, what types of surfaces it has problems detecting, how accurate the persistence feature is (i.e. how accurately the ARWorldMap reflects actual objects upon reloading geometry), and how long it takes to recognize a scene and reload an ARWorldMap.

![ARKit 2 Persistence and Plane Detection Demo Gif](https://github.com/robomex/ARKit-2-Persistence-and-Plane-Detection-Demo/blob/master/ARKit-2-Persistence-and-Plane-Detection-Demo.gif)
