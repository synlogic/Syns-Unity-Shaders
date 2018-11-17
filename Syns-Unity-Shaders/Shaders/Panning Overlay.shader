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
		uniform float4 _Tint;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _OverlayTexture;
		uniform float2 _OverlaySpeed;
		uniform sampler2D sampler0107;
		uniform float4 _OverlayTexture_ST;
		uniform float _OverlayAmount;
		uniform sampler2D _OverlayMask;
		uniform float4 _OverlayMask_ST;
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
			float clampResult103 = clamp( ase_lightAtten , 0.5 , 1.0 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 clampResult104 = clamp( ase_lightColor.rgb , float3( 0.5,0.5,0.5 ) , float3( 1,1,1 ) );
			float2 panner45 = ( _Time.y * _OverlaySpeed + ( ( i.uv_texcoord * _OverlayTexture_ST.xy ) + _OverlayTexture_ST.zw ));
			float2 uv_OverlayMask = i.uv_texcoord * _OverlayMask_ST.xy + _OverlayMask_ST.zw;
			float3 desaturateInitialColor111 = ( _OverlayAmount * tex2D( _OverlayMask, uv_OverlayMask ) ).rgb;
			float desaturateDot111 = dot( desaturateInitialColor111, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar111 = lerp( desaturateInitialColor111, desaturateDot111.xxx, 1.0 );
			float4 lerpResult95 = lerp( ( _Tint * tex2DNode1 ) , tex2D( _OverlayTexture, panner45 ) , desaturateVar111.x);
			float4 CustomLighting69 = ( float4( ( clampResult103 * clampResult104 ) , 0.0 ) * lerpResult95 );
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float2 panner45 = ( _Time.y * _OverlaySpeed + ( ( i.uv_texcoord * _OverlayTexture_ST.xy ) + _OverlayTexture_ST.zw ));
			float2 uv_OverlayMask = i.uv_texcoord * _OverlayMask_ST.xy + _OverlayMask_ST.zw;
			float3 desaturateInitialColor111 = ( _OverlayAmount * tex2D( _OverlayMask, uv_OverlayMask ) ).rgb;
			float desaturateDot111 = dot( desaturateInitialColor111, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar111 = lerp( desaturateInitialColor111, desaturateDot111.xxx, 1.0 );
			float4 lerpResult95 = lerp( ( _Tint * tex2DNode1 ) , tex2D( _OverlayTexture, panner45 ) , desaturateVar111.x);
			o.Emission = lerp(tex2D( _Emission, uv_Emission ),lerpResult95,_Unlit).rgb;
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
747;324;1517;696;793.0797;409.22;1.421807;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-1724.686,-22.13602;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureTransformNode;107;-1739.523,99.67252;Float;False;61;1;0;SAMPLER2D;sampler0107;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1422.476,23.8801;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;100;-1074.997,488.7548;Float;True;Property;_OverlayMask;Overlay Mask;8;0;Create;True;0;0;False;0;None;4d9e715431f8a564b9c286f42b977956;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;106;-1246.339,93.26752;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;52;-1263.348,357.9275;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;53;-1282.154,233.2756;Float;False;Property;_OverlaySpeed;Overlay Speed;7;0;Create;True;0;0;False;0;0,0;-0.5,-0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;88;-1059.945,408.6523;Float;False;Property;_OverlayAmount;Overlay Amount;6;0;Create;True;0;0;False;0;0.5;0.66;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;45;-1049.084,187.0141;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-671.7483,413.4777;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;13;-705.8225,-223.8412;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightAttenuation;12;-745.3172,-337.2844;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-772.0818,-36.21571;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;None;540adee7368365e4b9d552a63c77ceac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;39;-1007.486,-187.7439;Float;False;Property;_Tint;Tint;1;0;Create;True;0;0;False;0;0.7205882,0.7205882,0.7205882,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;103;-480.3438,-334.7167;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-458.2833,-84.62145;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;61;-770.7798,158.9894;Float;True;Property;_OverlayTexture;Overlay Texture;5;0;Create;True;0;0;False;0;None;b520269c431b7934eb6bbb1c32031e06;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;111;-513.7483,411.4777;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;104;-477.3069,-218.3827;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.5,0.5,0.5;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;95;-348.3999,146.3085;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-149.7259,-118.6767;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;9;-135.9827,-323.8198;Float;True;Property;_Emission;Emission;4;0;Create;True;0;0;False;0;None;4d9e715431f8a564b9c286f42b977956;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;188.9403,53.47229;Float;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-415.4467,55.86355;Float;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;455.6817,46.17504;Float;False;CustomLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;500.0211,-28.48227;Float;False;36;Mask;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;8;525.2836,-208.8654;Float;False;Property;_Unlit;Unlit;0;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;951.8345,-256.7975;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;SynLogic/Panning/Overlay;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;105;0;47;0
WireConnection;105;1;107;0
WireConnection;106;0;105;0
WireConnection;106;1;107;1
WireConnection;45;0;106;0
WireConnection;45;2;53;0
WireConnection;45;1;52;0
WireConnection;110;0;88;0
WireConnection;110;1;100;0
WireConnection;103;0;12;0
WireConnection;40;0;39;0
WireConnection;40;1;1;0
WireConnection;61;1;45;0
WireConnection;111;0;110;0
WireConnection;104;0;13;1
WireConnection;95;0;40;0
WireConnection;95;1;61;0
WireConnection;95;2;111;0
WireConnection;14;0;103;0
WireConnection;14;1;104;0
WireConnection;17;0;14;0
WireConnection;17;1;95;0
WireConnection;36;0;1;4
WireConnection;69;0;17;0
WireConnection;8;0;9;0
WireConnection;8;1;95;0
WireConnection;0;2;8;0
WireConnection;0;10;34;0
WireConnection;0;13;69;0
ASEEND*/
//CHKSM=9636A7668235DB46F693385B6C14AD1C137B798D
