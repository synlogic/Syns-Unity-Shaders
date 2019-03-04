// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SynLogic/Panning/Overlay"
{
	Properties
	{
		[Toggle]_Unlit("Unlit", Float) = 0
		_Tint("Tint", Color) = (0.7205882,0.7205882,0.7205882,0)
		_MainTex("MainTex", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Emission("Emission", 2D) = "black" {}
		_OverlayTexture("Overlay Texture", 2D) = "white" {}
		_OverlayAmount("Overlay Amount", Range( 0 , 2)) = 0.5
		_OverlaySpeed("Overlay Speed", Vector) = (0,0,0,0)
		_OverlayMask("Overlay Mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
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

		uniform float _Unlit;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform sampler2D _OverlayTexture;
		uniform float2 _OverlaySpeed;
		uniform float4 _OverlayTexture_ST;
		uniform float _OverlayAmount;
		uniform sampler2D _OverlayMask;
		uniform float4 _OverlayMask_ST;
		uniform float4 _Tint;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Cutoff = 0.5;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float Mask36 = tex2DNode1.a;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_cast_4 = (( ase_lightAtten * ase_lightColor.a )).xxx;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			UnityGI gi114 = gi;
			float3 diffNorm114 = ase_worldNormal;
			gi114 = UnityGI_Base( data, 1, diffNorm114 );
			float3 indirectDiffuse114 = gi114.indirect.diffuse + diffNorm114 * 0.0001;
			float3 clampResult103 = clamp( (( ase_lightAtten > 0.2 ) ? temp_cast_4 :  indirectDiffuse114 ) , float3( 0.1843137,0.1843137,0.1843137 ) , float3( 1,1,1 ) );
			float2 uv_OverlayTexture = i.uv_texcoord * _OverlayTexture_ST.xy + _OverlayTexture_ST.zw;
			float2 panner45 = ( _Time.y * _OverlaySpeed + uv_OverlayTexture);
			float4 tex2DNode61 = tex2D( _OverlayTexture, panner45 );
			float2 uv_OverlayMask = i.uv_texcoord * _OverlayMask_ST.xy + _OverlayMask_ST.zw;
			float3 desaturateInitialColor111 = ( _OverlayAmount * tex2D( _OverlayMask, uv_OverlayMask ) ).rgb;
			float desaturateDot111 = dot( desaturateInitialColor111, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar111 = lerp( desaturateInitialColor111, desaturateDot111.xxx, 1.0 );
			float4 lerpResult95 = lerp( ( _Tint * tex2DNode1 ) , tex2DNode61 , float4( desaturateVar111 , 0.0 ));
			float4 CustomLighting69 = ( float4( clampResult103 , 0.0 ) * lerpResult95 );
			c.rgb = CustomLighting69.rgb;
			c.a = 1;
			clip( Mask36 - _Cutoff );
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
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float2 uv_OverlayTexture = i.uv_texcoord * _OverlayTexture_ST.xy + _OverlayTexture_ST.zw;
			float2 panner45 = ( _Time.y * _OverlaySpeed + uv_OverlayTexture);
			float4 tex2DNode61 = tex2D( _OverlayTexture, panner45 );
			float2 uv_OverlayMask = i.uv_texcoord * _OverlayMask_ST.xy + _OverlayMask_ST.zw;
			float3 desaturateInitialColor111 = ( _OverlayAmount * tex2D( _OverlayMask, uv_OverlayMask ) ).rgb;
			float desaturateDot111 = dot( desaturateInitialColor111, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar111 = lerp( desaturateInitialColor111, desaturateDot111.xxx, 1.0 );
			float4 lerpResult113 = lerp( tex2D( _Emission, uv_Emission ) , tex2DNode61 , float4( desaturateVar111 , 0.0 ));
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float4 lerpResult95 = lerp( ( _Tint * tex2DNode1 ) , tex2DNode61 , float4( desaturateVar111 , 0.0 ));
			o.Emission = lerp(lerpResult113,lerpResult95,_Unlit).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
670;626;1517;767;1827.857;924.9089;1.630971;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;52;-1263.348,357.9275;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;13;-1141.25,-465.2621;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightAttenuation;12;-1195.508,-643.8668;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;53;-1282.154,233.2756;Float;False;Property;_OverlaySpeed;Overlay Speed;7;0;Create;True;0;0;False;0;0,0;-0.5,-0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;100;-1074.997,488.7548;Float;True;Property;_OverlayMask;Overlay Mask;8;0;Create;True;0;0;False;0;None;833d1b711357df04aa23240c8ccf87f0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-1059.945,408.6523;Float;False;Property;_OverlayAmount;Overlay Amount;6;0;Create;True;0;0;False;0;0.5;0.438;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-1334.288,110.6639;Float;False;0;61;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;118;-1134.797,-558.2191;Float;False;Constant;_Float0;Float 0;9;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-943.1,-444.8203;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;114;-1022.297,-336.9819;Float;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-671.7483,413.4777;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-772.0818,-36.21571;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;None;540adee7368365e4b9d552a63c77ceac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;39;-1007.486,-187.7439;Float;False;Property;_Tint;Tint;1;0;Create;True;0;0;False;0;0.7205882,0.7205882,0.7205882,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;45;-1049.084,187.0141;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCCompareGreater;117;-702.2312,-639.4091;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-458.2833,-84.62145;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;61;-770.7798,158.9894;Float;True;Property;_OverlayTexture;Overlay Texture;5;0;Create;True;0;0;False;0;None;c28f6ec75c833ac42b51607545b227ab;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;111;-513.7483,411.4777;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;103;-361.6279,-233.1599;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.1843137,0.1843137,0.1843137;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;9;-167.3826,-351.7199;Float;True;Property;_Emission;Emission;4;0;Create;True;0;0;False;0;None;833d1b711357df04aa23240c8ccf87f0;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;95;-157.2424,73.08006;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-392.2435,46.32283;Float;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;113;170.4036,-254.3805;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;183.3622,55.70356;Float;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;8;525.2836,-208.8654;Float;False;Property;_Unlit;Unlit;0;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureTransformNode;107;-1587.522,131.6725;Float;False;61;1;0;SAMPLER2D;sampler0107;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.GetLocalVarNode;34;500.0211,-28.48227;Float;False;36;Mask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;455.6817,46.17504;Float;False;CustomLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;951.8345,-256.7975;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;SynLogic/Panning/Overlay;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;47;0;107;0
WireConnection;47;1;107;1
WireConnection;112;0;12;0
WireConnection;112;1;13;2
WireConnection;110;0;88;0
WireConnection;110;1;100;0
WireConnection;45;0;47;0
WireConnection;45;2;53;0
WireConnection;45;1;52;0
WireConnection;117;0;12;0
WireConnection;117;1;118;0
WireConnection;117;2;112;0
WireConnection;117;3;114;0
WireConnection;40;0;39;0
WireConnection;40;1;1;0
WireConnection;61;1;45;0
WireConnection;111;0;110;0
WireConnection;103;0;117;0
WireConnection;95;0;40;0
WireConnection;95;1;61;0
WireConnection;95;2;111;0
WireConnection;36;0;1;4
WireConnection;113;0;9;0
WireConnection;113;1;61;0
WireConnection;113;2;111;0
WireConnection;17;0;103;0
WireConnection;17;1;95;0
WireConnection;8;0;113;0
WireConnection;8;1;95;0
WireConnection;69;0;17;0
WireConnection;0;2;8;0
WireConnection;0;10;34;0
WireConnection;0;13;69;0
ASEEND*/
//CHKSM=D7C6ADFEBC96CD63EA265E8BC8A958E15464A7C5