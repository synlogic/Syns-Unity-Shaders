// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SynLogic/Panning/Overlay and Outline"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Toggle]_Unlit("Unlit", Float) = 0
		_Tint("Tint", Color) = (0.7205882,0.7205882,0.7205882,0)
		_MainTex("MainTex", 2D) = "white" {}
		_Emission("Emission", 2D) = "black" {}
		[Toggle]_TextureOverlay("Texture Overlay", Float) = 1
		_OverlayTexture("Overlay Texture", 2D) = "white" {}
		_OverlayAmount("Overlay Amount", Range( 0 , 1)) = 0.5
		_OverlaySpeed("Overlay Speed", Vector) = (0,0,0,0)
		_OutlineTexture("Outline Texture", 2D) = "white" {}
		_OutlineSpeed("Outline Speed", Vector) = (0,0,0,0)
		_OutlineWidth("Outline Width", Float) = 0
		[Toggle]_Outline("Outline", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float OutlineChoice73 = lerp(0.0,1.0,_Outline);
			float outlineVar = (( OutlineChoice73 == 0.0 ) ? 0.0 :  _OutlineWidth );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float OutlineChoice73 = lerp(0.0,1.0,_Outline);
			float4 _Color0 = float4(0.5019608,0.5019608,0.5019608,0);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float4 temp_output_40_0 = ( _Tint * tex2DNode1 );
			float2 panner45 = ( _Time.y * _OverlaySpeed + i.uv_texcoord);
			float4 lerpResult95 = lerp( temp_output_40_0 , tex2D( _OverlayTexture, panner45 ) , _OverlayAmount);
			float4 temp_output_17_0 = ( ( ( _Color0 + 1 ) * ( _Color0 + ase_lightColor ) ) * lerp(temp_output_40_0,lerpResult95,_TextureOverlay) );
			float4 CustomLighting69 = temp_output_17_0;
			float2 panner49 = ( _Time.y * _OutlineSpeed + i.uv_texcoord);
			float4 tex2DNode20 = tex2D( _OutlineTexture, panner49 );
			o.Emission = ((( OutlineChoice73 == 0.0 ) ? CustomLighting69 :  tex2DNode20 )).rgb;
			clip( tex2DNode20.a - _Cutoff );
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
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
		uniform float _TextureOverlay;
		uniform float4 _Tint;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _OverlayTexture;
		uniform float2 _OverlaySpeed;
		uniform float _OverlayAmount;
		uniform float _Cutoff = 0.5;
		uniform float _Outline;
		uniform float _OutlineWidth;
		uniform sampler2D _OutlineTexture;
		uniform float2 _OutlineSpeed;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

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
			float4 _Color0 = float4(0.5019608,0.5019608,0.5019608,0);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_output_40_0 = ( _Tint * tex2DNode1 );
			float2 panner45 = ( _Time.y * _OverlaySpeed + i.uv_texcoord);
			float4 lerpResult95 = lerp( temp_output_40_0 , tex2D( _OverlayTexture, panner45 ) , _OverlayAmount);
			float4 temp_output_17_0 = ( ( ( _Color0 + ase_lightAtten ) * ( _Color0 + ase_lightColor ) ) * lerp(temp_output_40_0,lerpResult95,_TextureOverlay) );
			float4 CustomLighting69 = temp_output_17_0;
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
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 _Color0 = float4(0.5019608,0.5019608,0.5019608,0);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float4 temp_output_40_0 = ( _Tint * tex2DNode1 );
			float2 panner45 = ( _Time.y * _OverlaySpeed + i.uv_texcoord);
			float4 lerpResult95 = lerp( temp_output_40_0 , tex2D( _OverlayTexture, panner45 ) , _OverlayAmount);
			float4 temp_output_17_0 = ( ( ( _Color0 + 1 ) * ( _Color0 + ase_lightColor ) ) * lerp(temp_output_40_0,lerpResult95,_TextureOverlay) );
			o.Emission = lerp(tex2D( _Emission, uv_Emission ),temp_output_17_0,_Unlit).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

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
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
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
Version=15600
-1729;334;1664;833;2126.229;530.6783;2.090545;True;False
Node;AmplifyShaderEditor.Vector2Node;53;-1282.154,233.2756;Float;False;Property;_OverlaySpeed;Overlay Speed;8;0;Create;True;0;0;False;0;0,0;0,0.12;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-1324.008,121.4514;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;52;-1263.348,357.9275;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-770.3122,-25.59804;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;None;0f83c88893812674fb27a67cc3d624d9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;45;-1049.084,187.0141;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;39;-987.2325,-89.92628;Float;False;Property;_Tint;Tint;1;0;Create;True;0;0;False;0;0.7205882,0.7205882,0.7205882,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-458.2833,-84.62145;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;97;-752.9713,-484.824;Float;False;Constant;_Color0;Color 0;13;0;Create;True;0;0;False;0;0.5019608,0.5019608,0.5019608,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;13;-735.1954,-209.6603;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;61;-770.7798,158.9894;Float;True;Property;_OverlayTexture;Overlay Texture;6;0;Create;True;0;0;False;0;None;f30a8c09407cca044a4200ef24177ace;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-752.0447,346.2388;Float;False;Property;_OverlayAmount;Overlay Amount;7;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;12;-745.3172,-315.6647;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;98;-451.9713,-198.824;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;-447.9713,-398.824;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;83;-175.4347,614.5497;Float;False;645.6311;239.0216;Amplify doesn't allow toggles on the outline itself so had to improvise...;4;72;71;70;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;95;-348.3999,146.3085;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-125.4347,664.5497;Float;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;54;-693.4702,532.8367;Float;False;Property;_OutlineSpeed;Outline Speed;10;0;Create;True;0;0;False;0;0,0;0,0.18;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;72;-124.4066,738.5714;Float;False;Constant;_Float1;Float 1;12;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-740.8149,421.3364;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-196.0539,-181.9916;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;55;-678.8118,653.1664;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;6;-134.5209,32.97104;Float;False;Property;_TextureOverlay;Texture Overlay;5;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;175.0419,-5.209938;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;70;17.46836,689.2233;Float;False;Property;_Outline;Outline;12;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;49;-424.3013,384.6528;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-48.39203,203.8368;Float;False;Constant;_Float3;Float 3;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;73;227.1964,688.1958;Float;False;OutlineChoice;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;20;-160.3362,352.4974;Float;True;Property;_OutlineTexture;Outline Texture;9;0;Create;True;0;0;False;0;None;c7ca4eeb4e6b12d42973749820cd7704;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;82;-123.205,273.6379;Float;False;69;CustomLighting;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-104.8435,133.7302;Float;False;73;OutlineChoice;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;357.8004,34.94279;Float;False;CustomLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCCompareEqual;78;140.3326,180.0276;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;75;203.4531,394.003;Float;False;Constant;_Float2;Float 2;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;144.7964,318.8964;Float;False;73;OutlineChoice;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;170.06,467.7649;Float;False;Property;_OutlineWidth;Outline Width;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;26;368.8395,123.7993;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareEqual;74;388.1778,356.1938;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;90.83725,-293.7454;Float;True;Property;_Emission;Emission;4;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-405.8262,51.7314;Float;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;8;525.2836,-208.8654;Float;False;Property;_Unlit;Unlit;0;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;19;621.4982,118.2831;Float;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;594.7659,-59.8089;Float;False;36;Mask;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;951.8345,-256.7975;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;SynLogic/Panning/Overlay and Outline;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;45;0;47;0
WireConnection;45;2;53;0
WireConnection;45;1;52;0
WireConnection;40;0;39;0
WireConnection;40;1;1;0
WireConnection;61;1;45;0
WireConnection;98;0;97;0
WireConnection;98;1;13;0
WireConnection;96;0;97;0
WireConnection;96;1;12;0
WireConnection;95;0;40;0
WireConnection;95;1;61;0
WireConnection;95;2;88;0
WireConnection;14;0;96;0
WireConnection;14;1;98;0
WireConnection;6;0;40;0
WireConnection;6;1;95;0
WireConnection;17;0;14;0
WireConnection;17;1;6;0
WireConnection;70;0;71;0
WireConnection;70;1;72;0
WireConnection;49;0;48;0
WireConnection;49;2;54;0
WireConnection;49;1;55;0
WireConnection;73;0;70;0
WireConnection;20;1;49;0
WireConnection;69;0;17;0
WireConnection;78;0;81;0
WireConnection;78;1;79;0
WireConnection;78;2;82;0
WireConnection;78;3;20;0
WireConnection;26;0;78;0
WireConnection;74;0;77;0
WireConnection;74;1;75;0
WireConnection;74;2;75;0
WireConnection;74;3;22;0
WireConnection;36;0;1;4
WireConnection;8;0;9;0
WireConnection;8;1;17;0
WireConnection;19;0;26;0
WireConnection;19;2;20;4
WireConnection;19;1;74;0
WireConnection;0;2;8;0
WireConnection;0;10;34;0
WireConnection;0;13;69;0
WireConnection;0;11;19;0
ASEEND*/
//CHKSM=879972F7B08A06C5B28E401E083585895A423C43