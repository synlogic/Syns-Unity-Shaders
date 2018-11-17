// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SynLogic/Water v2"
{
	Properties
	{
		_Specular("Specular", Range( 0 , 5)) = 5
		_Gloss("Gloss", Range( 0 , 12)) = 1
		_SpecularDarkness("Specular Darkness", Range( -1 , 1)) = 1
		_MasterOpacity("Master Opacity", Range( 0 , 1)) = 1
		[Toggle]_DepthBasedOpacity("Depth Based Opacity", Float) = 1
		_OpacityDepth("Opacity Depth", Float) = 5
		_WaterTint("Water Tint", Color) = (0.5,0.6275861,1,1)
		_WaterOverlayTexture("Water Overlay Texture", 2D) = "white" {}
		_TextureVisibility("Texture Visibility", Range( 0 , 1)) = 0
		_Normals("Normals", 2D) = "bump" {}
		_NormalSpeed("Normal Speed", Vector) = (0,0.05,0,0)
		_Normal2Offset("Normal2 Offset", Vector) = (-0.5,0.3,0,0)
		_NormalStrength("Normal Strength", Float) = 0.5
		_ReflectionProbe("Reflection Probe", CUBE) = "white" {}
		_ReflectionStrength("Reflection Strength", Range( 0 , 1)) = 0.5
		_MaxTesDistance("Max Tes Distance", Range( 0 , 300)) = 5
		_MinTesDistance("Min Tes Distance", Range( 0 , 300)) = 0
		_TesselationFactor("Tesselation Factor", Range( 1 , 32)) = 32
		_WaveAmplitude("Wave Amplitude", Float) = 1
		_WaveHeight("Wave Height", Float) = 11
		_WaveSpeed("Wave Speed", Float) = 1
		_WaveSteepness("Wave Steepness", Float) = 1
		_WaveDirection1("Wave Direction 1", Color) = (0.6352941,1,0,0)
		_WaveDirection2("Wave Direction 2", Color) = (1,0.5586207,0,0)
		_WaveDirection3("Wave Direction 3", Color) = (0,0.9172413,1,0)
		_WaveDirection4("Wave Direction 4", Color) = (0.8602941,0,0,0)
		[Toggle]_FakeLightDir("Fake Light Dir", Float) = 0
		_FakeLightVector("Fake Light Vector", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf StandardCustomLighting keepalpha noshadow vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			float3 worldRefl;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldNormal;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _WaveSteepness;
		uniform float _WaveAmplitude;
		uniform float _WaveHeight;
		uniform float4 _WaveDirection4;
		uniform float _WaveSpeed;
		uniform float4 _WaveDirection1;
		uniform float4 _WaveDirection2;
		uniform float4 _WaveDirection3;
		uniform float _DepthBasedOpacity;
		uniform float _MasterOpacity;
		uniform sampler2D _CameraDepthTexture;
		uniform float _OpacityDepth;
		uniform samplerCUBE _ReflectionProbe;
		uniform float2 _Normal2Offset;
		uniform float2 _NormalSpeed;
		uniform sampler2D sampler0843;
		uniform sampler2D _Normals;
		uniform float4 _Normals_ST;
		uniform float _NormalStrength;
		uniform float4 _WaterTint;
		uniform float _ReflectionStrength;
		uniform sampler2D _WaterOverlayTexture;
		uniform float4 _WaterOverlayTexture_ST;
		uniform float _TextureVisibility;
		uniform float _FakeLightDir;
		uniform float3 _FakeLightVector;
		uniform float _Gloss;
		uniform float _Specular;
		uniform float _SpecularDarkness;
		uniform float _MinTesDistance;
		uniform float _MaxTesDistance;
		uniform float _TesselationFactor;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _MinTesDistance,_MaxTesDistance,_TesselationFactor);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float temp_output_13_0_g58 = ( ( 2.0 * UNITY_PI ) / _WaveAmplitude );
			float Wavelength18_g58 = temp_output_13_0_g58;
			float temp_output_47_0_g58 = _WaveHeight;
			float temp_output_20_0_g58 = ( temp_output_47_0_g58 * 2.0 );
			float temp_output_37_0_g58 = ( ( _WaveSteepness / ( ( Wavelength18_g58 * temp_output_20_0_g58 ) * ( 1.0 * ( 2.0 * UNITY_PI ) ) ) ) * temp_output_47_0_g58 );
			float4 temp_output_52_0_g58 = _WaveDirection4;
			float4 normalizeResult8_g58 = normalize( temp_output_52_0_g58 );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 transform5_g58 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float dotResult17_g58 = dot( normalizeResult8_g58 , float4( (transform5_g58).xyz , 0.0 ) );
			float temp_output_26_0_g58 = ( ( dotResult17_g58 * temp_output_13_0_g58 ) + ( ( temp_output_13_0_g58 * _WaveSpeed ) * _Time.y ) );
			float temp_output_31_0_g58 = cos( temp_output_26_0_g58 );
			float4 appendResult44_g58 = (float4(( temp_output_37_0_g58 * ( (temp_output_52_0_g58).r * temp_output_31_0_g58 ) ) , ( temp_output_37_0_g58 * ( (temp_output_52_0_g58).g * temp_output_31_0_g58 ) ) , ( temp_output_20_0_g58 * sin( temp_output_26_0_g58 ) ) , 0.0));
			float temp_output_13_0_g60 = ( ( 2.0 * UNITY_PI ) / _WaveAmplitude );
			float Wavelength18_g60 = temp_output_13_0_g60;
			float temp_output_47_0_g60 = _WaveHeight;
			float temp_output_20_0_g60 = ( temp_output_47_0_g60 * 2.0 );
			float temp_output_37_0_g60 = ( ( _WaveSteepness / ( ( Wavelength18_g60 * temp_output_20_0_g60 ) * ( 1.0 * ( 2.0 * UNITY_PI ) ) ) ) * temp_output_47_0_g60 );
			float4 temp_output_52_0_g60 = _WaveDirection1;
			float4 normalizeResult8_g60 = normalize( temp_output_52_0_g60 );
			float4 transform5_g60 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float dotResult17_g60 = dot( normalizeResult8_g60 , float4( (transform5_g60).xyz , 0.0 ) );
			float temp_output_26_0_g60 = ( ( dotResult17_g60 * temp_output_13_0_g60 ) + ( ( temp_output_13_0_g60 * _WaveSpeed ) * _Time.y ) );
			float temp_output_31_0_g60 = cos( temp_output_26_0_g60 );
			float4 appendResult44_g60 = (float4(( temp_output_37_0_g60 * ( (temp_output_52_0_g60).r * temp_output_31_0_g60 ) ) , ( temp_output_37_0_g60 * ( (temp_output_52_0_g60).g * temp_output_31_0_g60 ) ) , ( temp_output_20_0_g60 * sin( temp_output_26_0_g60 ) ) , 0.0));
			float temp_output_13_0_g62 = ( ( 2.0 * UNITY_PI ) / _WaveAmplitude );
			float Wavelength18_g62 = temp_output_13_0_g62;
			float temp_output_47_0_g62 = _WaveHeight;
			float temp_output_20_0_g62 = ( temp_output_47_0_g62 * 2.0 );
			float temp_output_37_0_g62 = ( ( _WaveSteepness / ( ( Wavelength18_g62 * temp_output_20_0_g62 ) * ( 1.0 * ( 2.0 * UNITY_PI ) ) ) ) * temp_output_47_0_g62 );
			float4 temp_output_52_0_g62 = _WaveDirection2;
			float4 normalizeResult8_g62 = normalize( temp_output_52_0_g62 );
			float4 transform5_g62 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float dotResult17_g62 = dot( normalizeResult8_g62 , float4( (transform5_g62).xyz , 0.0 ) );
			float temp_output_26_0_g62 = ( ( dotResult17_g62 * temp_output_13_0_g62 ) + ( ( temp_output_13_0_g62 * _WaveSpeed ) * _Time.y ) );
			float temp_output_31_0_g62 = cos( temp_output_26_0_g62 );
			float4 appendResult44_g62 = (float4(( temp_output_37_0_g62 * ( (temp_output_52_0_g62).r * temp_output_31_0_g62 ) ) , ( temp_output_37_0_g62 * ( (temp_output_52_0_g62).g * temp_output_31_0_g62 ) ) , ( temp_output_20_0_g62 * sin( temp_output_26_0_g62 ) ) , 0.0));
			float4 temp_output_863_0 = appendResult44_g62;
			float temp_output_13_0_g61 = ( ( 2.0 * UNITY_PI ) / _WaveAmplitude );
			float Wavelength18_g61 = temp_output_13_0_g61;
			float temp_output_47_0_g61 = _WaveHeight;
			float temp_output_20_0_g61 = ( temp_output_47_0_g61 * 2.0 );
			float temp_output_37_0_g61 = ( ( _WaveSteepness / ( ( Wavelength18_g61 * temp_output_20_0_g61 ) * ( 1.0 * ( 2.0 * UNITY_PI ) ) ) ) * temp_output_47_0_g61 );
			float4 temp_output_52_0_g61 = _WaveDirection3;
			float4 normalizeResult8_g61 = normalize( temp_output_52_0_g61 );
			float4 transform5_g61 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float dotResult17_g61 = dot( normalizeResult8_g61 , float4( (transform5_g61).xyz , 0.0 ) );
			float temp_output_26_0_g61 = ( ( dotResult17_g61 * temp_output_13_0_g61 ) + ( ( temp_output_13_0_g61 * _WaveSpeed ) * _Time.y ) );
			float temp_output_31_0_g61 = cos( temp_output_26_0_g61 );
			float4 appendResult44_g61 = (float4(( temp_output_37_0_g61 * ( (temp_output_52_0_g61).r * temp_output_31_0_g61 ) ) , ( temp_output_37_0_g61 * ( (temp_output_52_0_g61).g * temp_output_31_0_g61 ) ) , ( temp_output_20_0_g61 * sin( temp_output_26_0_g61 ) ) , 0.0));
			float4 temp_output_861_0 = appendResult44_g61;
			float4 break824 = ( ( appendResult44_g58 + appendResult44_g60 + temp_output_863_0 + temp_output_861_0 ) + ( temp_output_863_0 + temp_output_861_0 ) );
			float4 appendResult825 = (float4(break824.y , ( break824.x + break824.z ) , break824.x , 0.0));
			float4 VertexOffset800 = appendResult825;
			v.vertex.xyz += VertexOffset800.xyz;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth574 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth574 = abs( ( screenDepth574 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _OpacityDepth ) );
			float clampResult607 = clamp( ( distanceDepth574 + _MasterOpacity ) , 0.5 , 1.0 );
			float Opacity603 = lerp(_MasterOpacity,clampResult607,_DepthBasedOpacity);
			float2 panner247 = ( _Time.y * _NormalSpeed + i.uv_texcoord);
			float2 temp_output_845_0 = ( ( panner247 * _Normals_ST.xy ) + _Normals_ST.zw );
			float2 appendResult368 = (float2((temp_output_845_0).x , ( (temp_output_845_0).y + 1.0 )));
			float3 tex2DNode833 = UnpackNormal( tex2D( _Normals, appendResult368 ) );
			float4 lerpResult1116 = lerp( tex2D( _Normals, ( _Normal2Offset + appendResult368 ) ) , float4( tex2DNode833 , 0.0 ) , float4( 0.4980392,0.4980392,0.4980392,0.4980392 ));
			float4 Normals278 = ( lerpResult1116 * _NormalStrength );
			float4 lerpResult1081 = lerp( texCUBE( _ReflectionProbe, WorldReflectionVector( i , Normals278.rgb ) ) , _WaterTint , _ReflectionStrength);
			float2 uv_WaterOverlayTexture = i.uv_texcoord * _WaterOverlayTexture_ST.xy + _WaterOverlayTexture_ST.zw;
			float4 lerpResult911 = lerp( lerpResult1081 , ( tex2D( _WaterOverlayTexture, uv_WaterOverlayTexture ) * _WaterTint ) , _TextureVisibility);
			float4 Albedo322 = lerpResult911;
			float3 NormalMap1170 = tex2DNode833;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult1090 = normalize( ( lerp(ase_worldlightDir,_FakeLightVector,_FakeLightDir) + ase_worldViewDir ) );
			float dotResult1094 = dot( (WorldNormalVector( i , NormalMap1170 )) , normalizeResult1090 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 lerpResult1099 = lerp( Albedo322 , float4( ( pow( max( dotResult1094 , 0.0 ) , exp2( _Gloss ) ) * _Specular * ( ase_lightColor.rgb + _SpecularDarkness ) ) , 0.0 ) , float4( 0.5,0.5,0.5,0 ));
			float4 CustomLighting457 = lerpResult1099;
			c.rgb = CustomLighting457.rgb;
			c.a = Opacity603;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15800
109;606;1517;696;15.46826;796.4873;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;325;-1416.183,-563.6989;Float;False;2340.537;498.5604;;22;278;431;1116;432;833;1118;368;1117;365;561;369;366;367;845;844;1115;247;843;248;251;250;1170;Normals;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;251;-1348.208,-360.5059;Float;False;Property;_NormalSpeed;Normal Speed;11;0;Create;True;0;0;False;0;0,0.05;-0.001,-0.002;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;250;-1343.262,-223.9177;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;248;-1367.972,-488.8915;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;247;-1123.931,-391.7944;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureTransformNode;843;-1115.963,-260.1948;Float;False;833;1;0;SAMPLER2D;sampler0843;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;844;-905.9471,-385.1705;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;845;-725.2912,-387.4162;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;367;-548.5156,-206.6572;Float;False;Constant;_Float4;Float 4;19;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;366;-613.4913,-282.4912;Float;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;369;-574.5156,-440.3572;Float;False;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;365;-352.8092,-285.336;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;368;-235.4774,-375.5287;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;1117;-352.0123,-507.8367;Float;False;Property;_Normal2Offset;Normal2 Offset;12;0;Create;True;0;0;False;0;-0.5,0.3;1.04,1.22;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;1118;-94.7511,-499.5122;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;833;28.17516,-337.7886;Float;True;Property;_Normals;Normals;10;0;Create;True;0;0;False;0;49df81694b341684c82e6ae81650815e;644dd522bbaff7142b0bf8233e1e6284;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1115;29.43588,-529.5696;Float;True;Property;_TextureSample0;Texture Sample 0;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;833;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1116;340.1769,-439.9446;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.4980392,0.4980392,0.4980392,0.4980392;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;432;128.1613,-146.4667;Float;False;Property;_NormalStrength;Normal Strength;13;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;484;-1414.601,73.34521;Float;False;2539.465;706.1736;;21;1086;457;1099;1098;1097;1110;1096;506;1092;1095;1109;1105;1094;505;1090;1088;1106;1107;1133;1085;1172;Custom Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;431;514.0449,-439.499;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1085;-1375.545,257.7193;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;1107;-1356.861,447.8899;Float;False;Property;_FakeLightVector;Fake Light Vector;28;0;Create;True;0;0;False;0;0,0,0;-1.02,0.79,1.23;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;278;705.0173,-444.6927;Float;False;Normals;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;321;-1149.472,-1263.235;Float;False;2076.859;576.5083;;15;361;256;360;464;322;911;913;912;1081;910;259;172;1080;1082;1083;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;1086;-990.1123,521.8585;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1083;-861.8157,-1188.128;Float;False;278;Normals;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;849;-1146.116,955.6592;Float;False;2216.718;1143.494;Modified and cleaned up function from https://github.com/Safemilk/GerstnerWavesUnity;20;863;862;861;860;800;825;826;824;799;798;797;784;801;783;795;792;793;794;781;782;GerstnerWaves;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1170;512.8884,-338.2197;Float;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1106;-1030.596,339.7957;Float;False;Property;_FakeLightDir;Fake Light Dir;27;0;Create;True;0;0;False;0;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;793;-1101.895,1574.829;Float;False;Property;_WaveDirection1;Wave Direction 1;23;0;Create;True;0;0;False;0;0.6352941,1,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1133;-1331.109,123.1146;Float;False;1170;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;783;-1039.479,1355.055;Float;False;Constant;_amount;amount;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;1082;-649.8157,-1182.527;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;792;-1043.912,1005.659;Float;False;Property;_WaveDirection4;Wave Direction 4;26;0;Create;True;0;0;False;0;0.8602941,0,0,0;0.9448276,0,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;781;-1043.961,1181.914;Float;False;Property;_WaveHeight;Wave Height;20;0;Create;True;0;0;False;0;11;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;784;-1096.125,1502.865;Float;False;Property;_WaveSteepness;Wave Steepness;22;0;Create;True;0;0;False;0;1;7.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;795;-1065.104,1429.946;Float;False;Property;_WaveSpeed;Wave Speed;21;0;Create;True;0;0;False;0;1;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;801;-1091.228,1746.102;Float;False;Property;_WaveDirection2;Wave Direction 2;24;0;Create;True;0;0;False;0;1,0.5586207,0,0;0,1,0.04827528,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;782;-1048.863,1273.802;Float;False;Property;_WaveAmplitude;Wave Amplitude;19;0;Create;True;0;0;False;0;1;0.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1172;-763.8765,451.9071;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;794;-1082.935,1919.245;Float;False;Property;_WaveDirection3;Wave Direction 3;25;0;Create;True;0;0;False;0;0,0.9172413,1,0;0,0.2137927,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;604;-504.4742,-1660.708;Float;False;1419.643;331.6761;;8;1114;603;616;607;601;574;173;576;Opacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1080;-332.8799,-1208.722;Float;True;Property;_ReflectionProbe;Reflection Probe;14;0;Create;True;0;0;False;0;None;361292e520944f945b85ebb6dc6ffe20;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;172;-280.9067,-1012.042;Float;False;Property;_WaterTint;Water Tint;7;0;Create;True;0;0;False;0;0.5,0.6275861,1,1;0,0.5862069,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;1090;-558.4506,353.8669;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;259;-304.6617,-840.0042;Float;False;Property;_ReflectionStrength;Reflection Strength;15;0;Create;True;0;0;False;0;0.5;0.287;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1088;-1040.532,119.4193;Float;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;860;-621.8616,1353.914;Float;False;WaterWave;-1;;60;33ce65a09b35d3e4b9904c4149eac367;0;6;47;FLOAT;0;False;56;FLOAT;0;False;51;FLOAT;0;False;50;FLOAT;0;False;52;COLOR;0,0,0,0;False;57;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;862;-619.0605,1149.842;Float;False;WaterWave;-1;;58;33ce65a09b35d3e4b9904c4149eac367;0;6;47;FLOAT;0;False;56;FLOAT;0;False;51;FLOAT;0;False;50;FLOAT;0;False;52;COLOR;0,0,0,0;False;57;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;861;-614.7366,1752.611;Float;False;WaterWave;-1;;61;33ce65a09b35d3e4b9904c4149eac367;0;6;47;FLOAT;0;False;56;FLOAT;0;False;51;FLOAT;0;False;50;FLOAT;0;False;52;COLOR;0,0,0,0;False;57;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;863;-619.8616,1550.914;Float;False;WaterWave;-1;;62;33ce65a09b35d3e4b9904c4149eac367;0;6;47;FLOAT;0;False;56;FLOAT;0;False;51;FLOAT;0;False;50;FLOAT;0;False;52;COLOR;0,0,0,0;False;57;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;910;52.05169,-987.1734;Float;True;Property;_WaterOverlayTexture;Water Overlay Texture;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;912;74.16315,-789.1005;Float;False;Property;_TextureVisibility;Texture Visibility;9;0;Create;True;0;0;False;0;0;0.573;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;797;-206.7356,1211.811;Float;False;4;4;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;505;-548.5436,435.5999;Float;False;Property;_Gloss;Gloss;2;0;Create;True;0;0;False;0;1;12;0;12;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;576;-456.7389,-1619.119;Float;False;Property;_OpacityDepth;Opacity Depth;6;0;Create;True;0;0;False;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1094;-297.9269,302.1564;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1081;98.78415,-1221.2;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;798;-163.5357,1664.611;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;913;372.8158,-1061.302;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Exp2OpNode;1092;-133.279,405.5609;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-454.4741,-1531.562;Float;False;Property;_MasterOpacity;Master Opacity;4;0;Create;True;0;0;False;0;1;0.216;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;-557.5452,643.9532;Float;False;Property;_SpecularDarkness;Specular Darkness;3;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1095;-121.222,294.3688;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;911;568.3597,-1090.98;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;1105;-442.8814,520.2917;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.DepthFade;574;-227.1248,-1613.498;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;799;98.86371,1399.011;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;1096;26.34585,305.168;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;506;-274.2051,478.5825;Float;False;Property;_Specular;Specular;1;0;Create;True;0;0;False;0;5;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;601;30.4581,-1560.259;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;824;220.9619,1397.245;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1110;-212.0123,558.9402;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;322;728.4357,-1096.223;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1097;207.1086,302.0334;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1098;160.5185,216.218;Float;False;322;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;607;188.2125,-1545.394;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;826;485.7298,1415.2;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1099;391.3958,279.4485;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.5,0.5,0.5,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;825;613.9612,1395.339;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1114;371.2426,-1573.141;Float;False;Property;_DepthBasedOpacity;Depth Based Opacity;5;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;603;650.3109,-1570.628;Float;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;457;652.6683,275.5015;Float;False;CustomLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1113;-1121.88,2314.719;Float;False;1789.567;748.7534;Currently Unused;14;1129;1130;898;1128;902;886;901;900;1124;891;893;1123;889;1131;Normal Reconstruction;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;342;985.9902,-427.3336;Float;False;Property;_MinTesDistance;Min Tes Distance;17;0;Create;True;0;0;False;0;0;300;0;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;800;804.0302,1389.261;Float;True;VertexOffset;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;344;985.2053,-500.2697;Float;False;Property;_TesselationFactor;Tesselation Factor;18;0;Create;True;0;0;False;0;32;32;1;32;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;343;988.0153,-349.504;Float;False;Property;_MaxTesDistance;Max Tes Distance;16;0;Create;True;0;0;False;0;5;300;0;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;256;-1077.292,-973.359;Float;True;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;360;-559.923,-964.7585;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;159.935,-1625.164;Float;False;depth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;464;-801.3693,-965.0148;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;561;-573.1887,-368.811;Float;False;PannedUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureTransformNode;361;-825.9938,-868.7131;Float;False;-1;1;0;SAMPLER2D;sampler0361;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.GetLocalVarNode;722;1314.275,-607.4399;Float;False;800;VertexOffset;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;386;1299.98,-681.6998;Float;False;457;CustomLighting;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;605;1341.148,-780.4525;Float;False;603;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;898;-397.1368,2815.243;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;891;-673.7561,2803.018;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DdxOpNode;1123;-810.324,2430.198;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;341;1280.118,-459.1682;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1124;-681.114,2430.198;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;1129;-597.7603,2607.053;Float;False;Constant;_Float0;Float 0;29;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;886;383.6782,2624.154;Float;False;VertexNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;900;20.34666,2627.558;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1131;-371.169,2450.677;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1130;-597.8492,2681.554;Float;False;Constant;_Float1;Float 1;29;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToTangentMatrix;901;-124.0757,2743.355;Float;False;0;1;FLOAT3x3;0
Node;AmplifyShaderEditor.DdyOpNode;893;-814.3049,2803.015;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;887;1307.773,-538.9211;Float;False;886;VertexNormals;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;889;-1077.829,2624.945;Float;False;800;VertexOffset;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;902;198.4066,2628.333;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;1128;-152.8942,2625.931;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1592.341,-882.4985;Float;False;True;6;Float;ASEMaterialInspector;0;0;CustomLighting;SynLogic/Water v2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;12;10;25;False;1;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;247;0;248;0
WireConnection;247;2;251;0
WireConnection;247;1;250;0
WireConnection;844;0;247;0
WireConnection;844;1;843;0
WireConnection;845;0;844;0
WireConnection;845;1;843;1
WireConnection;366;0;845;0
WireConnection;369;0;845;0
WireConnection;365;0;366;0
WireConnection;365;1;367;0
WireConnection;368;0;369;0
WireConnection;368;1;365;0
WireConnection;1118;0;1117;0
WireConnection;1118;1;368;0
WireConnection;833;1;368;0
WireConnection;1115;1;1118;0
WireConnection;1116;0;1115;0
WireConnection;1116;1;833;0
WireConnection;431;0;1116;0
WireConnection;431;1;432;0
WireConnection;278;0;431;0
WireConnection;1170;0;833;0
WireConnection;1106;0;1085;0
WireConnection;1106;1;1107;0
WireConnection;1082;0;1083;0
WireConnection;1172;0;1106;0
WireConnection;1172;1;1086;0
WireConnection;1080;1;1082;0
WireConnection;1090;0;1172;0
WireConnection;1088;0;1133;0
WireConnection;860;47;781;0
WireConnection;860;56;782;0
WireConnection;860;51;783;0
WireConnection;860;50;784;0
WireConnection;860;52;793;0
WireConnection;860;57;795;0
WireConnection;862;47;781;0
WireConnection;862;56;782;0
WireConnection;862;51;783;0
WireConnection;862;50;784;0
WireConnection;862;52;792;0
WireConnection;862;57;795;0
WireConnection;861;47;781;0
WireConnection;861;56;782;0
WireConnection;861;51;783;0
WireConnection;861;50;784;0
WireConnection;861;52;794;0
WireConnection;861;57;795;0
WireConnection;863;47;781;0
WireConnection;863;56;782;0
WireConnection;863;51;783;0
WireConnection;863;50;784;0
WireConnection;863;52;801;0
WireConnection;863;57;795;0
WireConnection;797;0;862;0
WireConnection;797;1;860;0
WireConnection;797;2;863;0
WireConnection;797;3;861;0
WireConnection;1094;0;1088;0
WireConnection;1094;1;1090;0
WireConnection;1081;0;1080;0
WireConnection;1081;1;172;0
WireConnection;1081;2;259;0
WireConnection;798;0;863;0
WireConnection;798;1;861;0
WireConnection;913;0;910;0
WireConnection;913;1;172;0
WireConnection;1092;0;505;0
WireConnection;1095;0;1094;0
WireConnection;911;0;1081;0
WireConnection;911;1;913;0
WireConnection;911;2;912;0
WireConnection;574;0;576;0
WireConnection;799;0;797;0
WireConnection;799;1;798;0
WireConnection;1096;0;1095;0
WireConnection;1096;1;1092;0
WireConnection;601;0;574;0
WireConnection;601;1;173;0
WireConnection;824;0;799;0
WireConnection;1110;0;1105;1
WireConnection;1110;1;1109;0
WireConnection;322;0;911;0
WireConnection;1097;0;1096;0
WireConnection;1097;1;506;0
WireConnection;1097;2;1110;0
WireConnection;607;0;601;0
WireConnection;826;0;824;0
WireConnection;826;1;824;2
WireConnection;1099;0;1098;0
WireConnection;1099;1;1097;0
WireConnection;825;0;824;1
WireConnection;825;1;826;0
WireConnection;825;2;824;0
WireConnection;1114;0;173;0
WireConnection;1114;1;607;0
WireConnection;603;0;1114;0
WireConnection;457;0;1099;0
WireConnection;800;0;825;0
WireConnection;360;0;464;0
WireConnection;360;1;361;1
WireConnection;616;0;574;0
WireConnection;464;0;256;0
WireConnection;561;0;845;0
WireConnection;898;0;1130;0
WireConnection;898;1;891;2
WireConnection;898;2;1129;0
WireConnection;891;0;893;0
WireConnection;1123;0;889;0
WireConnection;341;0;344;0
WireConnection;341;1;342;0
WireConnection;341;2;343;0
WireConnection;1124;0;1123;0
WireConnection;886;0;902;0
WireConnection;900;0;1128;0
WireConnection;1131;0;1129;0
WireConnection;1131;1;1124;2
WireConnection;1131;2;1130;0
WireConnection;893;0;889;0
WireConnection;902;0;900;0
WireConnection;902;1;901;0
WireConnection;1128;0;898;0
WireConnection;1128;1;1131;0
WireConnection;0;9;605;0
WireConnection;0;13;386;0
WireConnection;0;11;722;0
WireConnection;0;14;341;0
ASEEND*/
//CHKSM=48ED1C228CFC61AD0C9FDC75D032D232279585A7