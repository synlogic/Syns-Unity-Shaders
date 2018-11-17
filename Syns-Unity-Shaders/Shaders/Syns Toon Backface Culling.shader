// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SynLogic/Toon/Toon Backface Culling"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Tint("Tint", Color) = (1,1,1,1)
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Ramp("Ramp", 2D) = "white" {}
		_Shading("Shading", Range( 0 , 1)) = 0.25
		_Emission("Emission", 2D) = "black" {}
		_FakeLightDirection("Fake Light Direction", Vector) = (0,0.37,0.31,0)
		[Toggle]_FakeLighting("Fake Lighting", Float) = 1
		_NormalMap("Normal Map", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			float3 viewDir;
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

		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Shading;
		uniform float4 _Tint;
		uniform sampler2D _Ramp;
		uniform float _FakeLighting;
		uniform float3 _FakeLightDirection;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _Cutoff = 0.5;


		float3x3 CotangentFrame( float3 normal , float3 position , float2 uv )
		{
			float3 dp1 = ddx ( position );
			float3 dp2 = ddy ( position );
			float2 duv1 = ddx ( uv );
			float2 duv2 = ddy ( uv );
			float3 dp2perp = cross ( dp2, normal );
			float3 dp1perp = cross ( normal, dp1 );
			float3 tangent = dp2perp * duv1.x + dp1perp * duv2.x;
			float3 bitangent = dp2perp * duv1.y + dp1perp * duv2.y;
			float invmax = rsqrt ( max ( dot ( tangent, tangent ), dot ( bitangent, bitangent ) ) );
			tangent *= invmax;
			bitangent *= invmax;
			return float3x3 (	tangent.x, bitangent.x, normal.x,
								tangent.y, bitangent.y, normal.y,
								tangent.z, bitangent.z, normal.z );
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
			float4 MainTex62 = tex2DNode1;
			float TintAlpha147 = _Tint.a;
			float clampResult143 = clamp( ( (MainTex62).a * TintAlpha147 ) , 0.0 , 1.0 );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 LightDir98 = (( 1.0 == lerp(0.0,1.0,_FakeLighting) ) ? _FakeLightDirection :  ase_worldlightDir );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 normal3_g7 = ase_normWorldNormal;
			float3 position3_g7 = i.viewDir;
			float2 uv3_g7 = i.uv_texcoord;
			float3x3 localCotangentFrame3_g7 = CotangentFrame( normal3_g7 , position3_g7 , uv3_g7 );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 temp_output_6_0_g1 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float3 temp_output_24_0_g1 = mul( localCotangentFrame3_g7, temp_output_6_0_g1 );
			float dotResult24 = dot( LightDir98 , BlendNormals( temp_output_24_0_g1 , ase_worldNormal ) );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 toLight109 = ( LightDir98 - ase_vertex3Pos );
			float d114 = length( toLight109 );
			float clampResult116 = clamp( d114 , 0.0 , 1.0 );
			float fakeAtten115 = pow( clampResult116 , 10.0 );
			float LightAtten100 = (( lerp(0.0,1.0,_FakeLighting) == 1.0 ) ? fakeAtten115 :  ase_lightAtten );
			float smoothstepResult59 = smoothstep( 0.0 , 0.5 , ( LightAtten100 + float4(0.5,0.5,0.5,0) ).r);
			float2 temp_cast_2 = (( (dotResult24*0.5 + 0.5) * smoothstepResult59 )).xx;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 clampResult155 = clamp( ase_lightColor , float4( 0.2647059,0.2647059,0.2647059,0 ) , float4( 1,1,1,0 ) );
			float4 CustomLighting8 = ( _Tint * ( tex2D( _Ramp, temp_cast_2 ) * tex2DNode1 ) * clampResult155 );
			c.rgb = CustomLighting8.rgb;
			c.a = 1;
			clip( clampResult143 - _Cutoff );
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
			float4 MainTex62 = tex2DNode1;
			float4 lerpResult138 = lerp( tex2D( _Emission, uv_Emission ) , ( MainTex62 * _Shading ) , 0.5);
			o.Emission = lerpResult138.rgb;
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
				float3 worldNormal : TEXCOORD3;
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
				o.worldNormal = worldNormal;
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
				surfIN.viewDir = worldViewDir;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
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
-1652;370;1517;777;3091.508;756.2061;3.546686;True;False
Node;AmplifyShaderEditor.CommentaryNode;107;-301.7111,-562.4966;Float;False;1122.138;704.9326;;11;91;92;101;86;87;23;93;94;100;98;106;FakeLight Switch;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-250.7111,-248.7253;Float;False;Constant;_Float6;Float 6;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-251.7111,-169.7255;Float;False;Constant;_Float7;Float 7;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;86;-86.42641,-513.7529;Float;False;Property;_FakeLightDirection;Fake Light Direction;6;0;Create;True;0;0;False;0;0,0.37,0.31;0,0.37,0.31;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ToggleSwitchNode;87;-37.75558,-218.0824;Float;False;Property;_FakeLighting;Fake Lighting;7;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;23;-36.94851,-365.3651;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;127;-1343.071,-702.1335;Float;False;1021.601;840.3081;Used formula from http://learnwebgl.brown37.net/09_lights/lights_attenuation.html ;14;115;125;116;126;119;114;121;120;113;112;109;111;108;110;Fake Attenuation;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCCompareEqual;93;344.6918,-414.93;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;-1214.444,-652.1335;Float;True;98;LightDir;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;98;568.4261,-419.5648;Float;False;LightDir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;110;-1208.471,-457.6757;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;111;-884.4704,-506.6755;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-1199.124,-285.6758;Float;False;109;toLight;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-701.0455,-507.0066;Float;False;toLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;113;-987.4709,-279.6758;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;119;-1291.354,-191.7155;Float;False;114;d;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-822.4704,-288.6758;Float;False;d;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-1257.309,-120.4019;Float;False;Constant;_Float9;Float 9;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-1253.688,-48.02309;Float;False;Constant;_Float10;Float 10;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;126;-1009.718,29.61765;Float;False;Constant;_Float8;Float 8;12;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;116;-1082.309,-186.9801;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;125;-814.717,-148.3823;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;39;-1791.531,199.4295;Float;False;2614.047;807.4423;;26;8;88;13;147;4;155;25;12;154;62;1;35;59;32;151;60;24;61;30;152;102;133;103;132;29;129;Custom Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.LightAttenuation;101;61.85311,34.07213;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;81.71805,-41.9494;Float;False;115;fakeAtten;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-564.4701,-155.6756;Float;False;fakeAtten;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;129;-1764.223,322.061;Float;True;Property;_NormalMap;Normal Map;8;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;29;-1464.653,501.7332;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCCompareEqual;94;342.5868,-76.72597;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;132;-1462.469,327.0919;Float;False;PerturbNormal;-1;;1;c8b64dd82fb09f542943a895dffb6c06;1,26,0;1;6;FLOAT3;0,0,0;False;4;FLOAT3;9;FLOAT;28;FLOAT;29;FLOAT;30
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;573.4261,-82.5646;Float;False;LightAtten;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;-988.3114,564.9131;Float;False;100;LightAtten;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;133;-1218.469,424.0919;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;-1204.629,338.7718;Float;False;98;LightDir;0;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;152;-1041.628,649.975;Float;False;Constant;_Color0;Color 0;11;0;Create;True;0;0;False;0;0.5,0.5,0.5,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-974.5936,484.5788;Float;False;Constant;_Lambert;Lambert;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-749.3766,775.0588;Float;False;Constant;_Float4;Float 4;6;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;24;-989.3578,357.6363;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-741.3766,696.0587;Float;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;151;-724.6277,602.975;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;32;-721.2487,449.4748;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;59;-548.9766,615.0587;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-371.3771,520.8958;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-233.1176,681.3386;Float;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;False;0;None;0f83c88893812674fb27a67cc3d624d9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;172.7012,797.7515;Float;False;MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;12;177.7629,403.9521;Float;False;Property;_Tint;Tint;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-210.7485,424.6297;Float;True;Property;_Ramp;Ramp;3;0;Create;True;0;0;False;0;3be78a7d184b7a749a24658ebc3c6b2f;3be78a7d184b7a749a24658ebc3c6b2f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;63;899.0446,193.2457;Float;False;62;MainTex;0;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;154;29.29291,875.105;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;149;1138.494,282.1607;Float;False;147;TintAlpha;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;179.651,574.3721;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;1042.799,-6.776114;Float;False;62;MainTex;0;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;155;236.7021,875.8785;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.2647059,0.2647059,0.2647059,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;137;1113.382,202.0023;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;947.7339,84.09155;Float;False;Property;_Shading;Shading;4;0;Create;True;0;0;False;0;0.25;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;147;423.2106,396.0072;Float;False;TintAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;1121.085,-235.8658;Float;True;Property;_Emission;Emission;5;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;1293.734,-2.908428;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;144;1484.037,175.8299;Float;False;Constant;_Float12;Float 12;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;1278.018,98.68719;Float;False;Constant;_Float11;Float 11;11;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;150;1334.494,219.1607;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;441.1548,543.967;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;145;1485.325,250.5051;Float;False;Constant;_Float13;Float 13;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;138;1482.018,-85.31281;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;10;1430.951,323.1852;Float;False;8;CustomLighting;0;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;143;1651.414,222.18;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-1136.559,566.9871;Float;False;Constant;_Float5;Float 5;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;592.5181,539.6337;Float;True;CustomLighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1845.668,86.82019;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;SynLogic/Toon/Toon Backface Culling;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;87;0;91;0
WireConnection;87;1;92;0
WireConnection;93;0;92;0
WireConnection;93;1;87;0
WireConnection;93;2;86;0
WireConnection;93;3;23;0
WireConnection;98;0;93;0
WireConnection;111;0;108;0
WireConnection;111;1;110;0
WireConnection;109;0;111;0
WireConnection;113;0;112;0
WireConnection;114;0;113;0
WireConnection;116;0;119;0
WireConnection;116;1;120;0
WireConnection;116;2;121;0
WireConnection;125;0;116;0
WireConnection;125;1;126;0
WireConnection;115;0;125;0
WireConnection;94;0;87;0
WireConnection;94;1;92;0
WireConnection;94;2;106;0
WireConnection;94;3;101;0
WireConnection;132;6;129;0
WireConnection;100;0;94;0
WireConnection;133;0;132;9
WireConnection;133;1;29;0
WireConnection;24;0;102;0
WireConnection;24;1;133;0
WireConnection;151;0;103;0
WireConnection;151;1;152;0
WireConnection;32;0;24;0
WireConnection;32;1;30;0
WireConnection;32;2;30;0
WireConnection;59;0;151;0
WireConnection;59;1;60;0
WireConnection;59;2;61;0
WireConnection;35;0;32;0
WireConnection;35;1;59;0
WireConnection;62;0;1;0
WireConnection;25;1;35;0
WireConnection;4;0;25;0
WireConnection;4;1;1;0
WireConnection;155;0;154;0
WireConnection;137;0;63;0
WireConnection;147;0;12;4
WireConnection;65;0;67;0
WireConnection;65;1;66;0
WireConnection;150;0;137;0
WireConnection;150;1;149;0
WireConnection;13;0;12;0
WireConnection;13;1;4;0
WireConnection;13;2;155;0
WireConnection;138;0;69;0
WireConnection;138;1;65;0
WireConnection;138;2;139;0
WireConnection;143;0;150;0
WireConnection;143;1;144;0
WireConnection;143;2;145;0
WireConnection;8;0;13;0
WireConnection;0;2;138;0
WireConnection;0;10;143;0
WireConnection;0;13;10;0
ASEEND*/
//CHKSM=B5D198D1A13D3154370DDD4573C27833CAD0AA65