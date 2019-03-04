# Syn's Unity Shaders
A set of fun/useful shaders for use in VRChat and Unity.  

## As of 11/17/2018 I have moved the shaders from ShaderForge to Amplify.
## I have also added example scenes and improved on a lot of the shaders code.  There is also now a toon shader!

# How to add to assets?  
Download the latest release at the link below, and unzip into your Assets directory.  
https://github.com/synlogic/Syns-Unity-Shaders/releases/latest
  
# Avatar Shaders
+<img src="Syns-Unity-Shaders/Assets/avatar-shaders.gif?raw=true">
  
# Toon
A simple toon shader for VRChat models.
  * Mask Clip Value:  Transparency Cutout percentage
  * Ramp:  Determines the shape and color of the shadows
  * Outline Color:  Color of the outline
  * Outline Size:  Size of the outline
  * Shading:  Overall brightness of the model.
  * Fake Lighting Toggle:  Toggles a static light direction.
  * Fake Light Direction:  Static light direction.
  
# ScanLine  
Swaps between two textures based on speed and harshness set.
  * Tint:      Overall tint of the Texture
  * Speed:     Speed of the scanline
  * Harshness: How soft or harsh the scanline is
  * Unlit:     Toggles whether or not the material is Unlit
  
# PanningOutline and Texture Overlay
Pans a texture around the outline and/or on-top of a mesh.  
  * Unlit:     		 Toggles whether or not the material is Unlit
  * Tint:  			 Tint of MainTex
  * Overlay Amount:  Amount of the OverlayTexture is shown
  * Overlay Speed:   Vector2 (UV) speed of the Overlay's panning
  * Outline Speed:   Vector2 (UV) speed of the outline's panning
  * Outline Width:   Width of the outline (Smaller numbers work best EX .002)
  
  
# WaterShader  
Example scene: Examples/Water
+<img src="Syns-Unity-Shaders/Assets/water-shader.png?raw=true">  
Simulates nice looking water.
  * Specular:            Specularity of the water
  * Gloss:  			 Glossiness of the water, higher the more wet looking.
  * Specular Darkness:   Changes the darkness of the specular highlights.
  * Master Opacity:  	 Controls the opacity of the water.
  * Depth Based Opacity: Enables depth based opacity simulating darker/lighter waters with background geometery.
  * Opacity Depth:       How far it takes to go from 0-1 opacity.
  * Water Tint:          Overall tint of the water.
  * Water Overlay:       Allows for a texture to be overlayed onto the water.
  * Normal Speed:        Speed the normals pan.
  * Normal 2 Offset:     Offset of the copy of the first normals
  * Reflection Probe:    Set to a cubemap to give reflections of a skybox
  * Reflection Strength: Intensity of the reflection, smaller is more.
  
  **Tesselation Options**
  * Tesselation Factor:   Amount of tesselation, used to smooth vertex movement.
  * Max Tes Distance:     Maximum distance for tesselation effect.
  * Min Tes Distance:     Minimum distance for tesselation effect.
  
  **Gertscher Wave Vertex Offset**
  * Vertex Offset Toggle: Disables/Enables the wave function
  * Wave Amplitude:     Can be used to set amount of waves
  * Wave Height:        Height of the waves
  * Wave Speed:         Speed of the waves
  * Wave Direction 1-4: Changes the shape and direction of the waves.  Having multiple values is generally desirable.
