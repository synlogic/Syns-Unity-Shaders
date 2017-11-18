// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0.2887928,fgcb:0.625,fgca:1,fgde:0.03,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35600,y:32817,varname:node_2865,prsc:2|diff-9347-OUT,spec-2046-OUT,gloss-8395-OUT,normal-4289-OUT,amdfl-9347-OUT,alpha-6665-A,voffset-3858-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:33828,y:32853,ptovrint:False,ptlb:Water Tint,ptin:_WaterTint,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.4126267,c3:0.5808823,c4:0.928;n:type:ShaderForge.SFN_Time,id:8644,x:33113,y:33493,varname:node_8644,prsc:2;n:type:ShaderForge.SFN_Multiply,id:25,x:33325,y:33463,varname:node_25,prsc:2|A-851-OUT,B-8644-T,C-6297-OUT;n:type:ShaderForge.SFN_Append,id:1298,x:33704,y:33440,varname:node_1298,prsc:2|A-3713-OUT,B-139-OUT;n:type:ShaderForge.SFN_Vector1,id:3713,x:33525,y:33404,varname:node_3713,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Sin,id:139,x:33525,y:33463,varname:node_139,prsc:2|IN-25-OUT;n:type:ShaderForge.SFN_Multiply,id:3858,x:33891,y:33440,varname:node_3858,prsc:2|A-1298-OUT,B-2084-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2084,x:33704,y:33593,ptovrint:False,ptlb:WaveIntensity,ptin:_WaveIntensity,varname:node_2084,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Noise,id:851,x:33113,y:33373,varname:node_851,prsc:2|XY-8508-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:8508,x:32939,y:33373,varname:node_8508,prsc:2,uv:0,uaff:True;n:type:ShaderForge.SFN_DepthBlend,id:7679,x:33410,y:33136,varname:node_7679,prsc:2|DIST-8632-OUT;n:type:ShaderForge.SFN_OneMinus,id:4118,x:33591,y:33136,varname:node_4118,prsc:2|IN-7679-OUT;n:type:ShaderForge.SFN_Multiply,id:5718,x:33771,y:33115,varname:node_5718,prsc:2|A-8908-OUT,B-4118-OUT,C-4160-OUT;n:type:ShaderForge.SFN_Tex2d,id:5253,x:33376,y:32957,ptovrint:False,ptlb:FoamTexture,ptin:_FoamTexture,varname:node_5253,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:8632,x:33220,y:33136,ptovrint:False,ptlb:FoamRange,ptin:_FoamRange,varname:node_8632,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Blend,id:7491,x:34349,y:32987,varname:node_7491,prsc:2,blmd:6,clmp:True|SRC-306-OUT,DST-5718-OUT;n:type:ShaderForge.SFN_DepthBlend,id:9559,x:33534,y:32625,varname:node_9559,prsc:2|DIST-5521-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5521,x:33362,y:32625,ptovrint:False,ptlb:DarknessDistance,ptin:_DarknessDistance,varname:node_5521,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:3574,x:33707,y:32625,varname:node_3574,prsc:2|IN-9559-OUT;n:type:ShaderForge.SFN_Multiply,id:8908,x:33591,y:32974,varname:node_8908,prsc:2|A-8353-RGB,B-5253-RGB;n:type:ShaderForge.SFN_Color,id:8353,x:33376,y:32793,ptovrint:False,ptlb:FoamTexture_Tint,ptin:_FoamTexture_Tint,varname:node_8353,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_LightAttenuation,id:4440,x:34067,y:33328,varname:node_4440,prsc:2;n:type:ShaderForge.SFN_LightColor,id:6296,x:34067,y:33483,varname:node_6296,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8015,x:34268,y:33406,varname:node_8015,prsc:2|A-4440-OUT,B-6296-RGB;n:type:ShaderForge.SFN_Slider,id:6297,x:33180,y:33648,ptovrint:False,ptlb:WaveSpeed,ptin:_WaveSpeed,varname:node_6297,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.006644173,max:10;n:type:ShaderForge.SFN_Vector1,id:4160,x:33591,y:33260,varname:node_4160,prsc:2,v1:1;n:type:ShaderForge.SFN_Add,id:1525,x:34464,y:33383,varname:node_1525,prsc:2|A-7966-OUT,B-8015-OUT;n:type:ShaderForge.SFN_Vector3,id:7966,x:34268,y:33313,varname:node_7966,prsc:2,v1:0.5,v2:0.5,v3:0.5;n:type:ShaderForge.SFN_TexCoord,id:9585,x:34390,y:32297,varname:node_9585,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:7857,x:34739,y:32575,varname:node_7857,prsc:2,ntxv:3,isnm:True|UVIN-8291-OUT,TEX-6240-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:6240,x:34431,y:32676,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_6240,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:8838,x:34739,y:32740,varname:node_8838,prsc:2,ntxv:0,isnm:False|TEX-6240-TEX;n:type:ShaderForge.SFN_Blend,id:4289,x:35080,y:32688,varname:node_4289,prsc:2,blmd:10,clmp:True|SRC-7857-RGB,DST-8838-RGB;n:type:ShaderForge.SFN_Slider,id:8395,x:35182,y:32983,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_8395,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.95,max:1;n:type:ShaderForge.SFN_Slider,id:2046,x:35182,y:32891,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_2046,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.35,max:1;n:type:ShaderForge.SFN_ValueProperty,id:5094,x:34042,y:32330,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_5094,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.0005;n:type:ShaderForge.SFN_Append,id:1868,x:34224,y:32348,varname:node_1868,prsc:2|A-5094-OUT,B-5094-OUT;n:type:ShaderForge.SFN_Multiply,id:2292,x:34390,y:32461,varname:node_2292,prsc:2|A-1868-OUT,B-9780-T;n:type:ShaderForge.SFN_Add,id:8291,x:34576,y:32478,varname:node_8291,prsc:2|A-9585-UVOUT,B-2292-OUT;n:type:ShaderForge.SFN_Time,id:9780,x:34224,y:32505,varname:node_9780,prsc:2;n:type:ShaderForge.SFN_Multiply,id:306,x:34139,y:32767,varname:node_306,prsc:2|A-5876-OUT,B-6665-RGB;n:type:ShaderForge.SFN_If,id:5876,x:33924,y:32593,varname:node_5876,prsc:2|A-3574-OUT,B-3848-OUT,GT-3574-OUT,EQ-3848-OUT,LT-3848-OUT;n:type:ShaderForge.SFN_Vector1,id:3848,x:33707,y:32750,varname:node_3848,prsc:2,v1:0.3;n:type:ShaderForge.SFN_SwitchProperty,id:9347,x:34576,y:32967,ptovrint:False,ptlb:Foam,ptin:_Foam,varname:node_9347,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-306-OUT,B-7491-OUT;proporder:6665-2084-5253-8632-5521-8353-6297-6240-8395-2046-5094-9347;pass:END;sub:END;*/

Shader "SynLogic/Water Shader" {
    Properties {
        _WaterTint ("Water Tint", Color) = (0,0.4126267,0.5808823,0.928)
        _WaveIntensity ("WaveIntensity", Float ) = 1
        _FoamTexture ("FoamTexture", 2D) = "white" {}
        _FoamRange ("FoamRange", Float ) = 0
        _DarknessDistance ("DarknessDistance", Float ) = 1
        _FoamTexture_Tint ("FoamTexture_Tint", Color) = (1,1,1,1)
        _WaveSpeed ("WaveSpeed", Range(0, 10)) = 0.006644173
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _Gloss ("Gloss", Range(0, 1)) = 0.95
        _Specular ("Specular", Range(0, 1)) = 0.35
        _Speed ("Speed", Float ) = 0.0005
        [MaterialToggle] _Foam ("Foam", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _WaterTint;
            uniform float _WaveIntensity;
            uniform sampler2D _FoamTexture; uniform float4 _FoamTexture_ST;
            uniform float _FoamRange;
            uniform float _DarknessDistance;
            uniform float4 _FoamTexture_Tint;
            uniform float _WaveSpeed;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Gloss;
            uniform float _Specular;
            uniform float _Speed;
            uniform fixed _Foam;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 projPos : TEXCOORD7;
                UNITY_FOG_COORDS(8)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD9;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float2 node_851_skew = o.uv0 + 0.2127+o.uv0.x*0.3713*o.uv0.y;
                float2 node_851_rnd = 4.789*sin(489.123*(node_851_skew));
                float node_851 = frac(node_851_rnd.x*node_851_rnd.y*(1+node_851_skew.x));
                float4 node_8644 = _Time;
                v.vertex.xyz += float3((float2(0.5,sin((node_851*node_8644.g*_WaveSpeed)))*_WaveIntensity),0.0);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_9780 = _Time;
                float2 node_8291 = (i.uv0+(float2(_Speed,_Speed)*node_9780.g));
                float3 node_7857 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_8291, _NormalMap)));
                float3 node_8838 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = saturate(( node_8838.rgb > 0.5 ? (1.0-(1.0-2.0*(node_8838.rgb-0.5))*(1.0-node_7857.rgb)) : (2.0*node_8838.rgb*node_7857.rgb) ));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularColor = float3(_Specular,_Specular,_Specular);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 indirectSpecular = (gi.indirect.specular)*specularColor;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                float node_3574 = (1.0 - saturate((sceneZ-partZ)/_DarknessDistance));
                float node_3848 = 0.3;
                float node_5876_if_leA = step(node_3574,node_3848);
                float node_5876_if_leB = step(node_3848,node_3574);
                float3 node_306 = (lerp((node_5876_if_leA*node_3848)+(node_5876_if_leB*node_3574),node_3848,node_5876_if_leA*node_5876_if_leB)*_WaterTint.rgb);
                float4 _FoamTexture_var = tex2D(_FoamTexture,TRANSFORM_TEX(i.uv0, _FoamTexture));
                float3 _Foam_var = lerp( node_306, saturate((1.0-(1.0-node_306)*(1.0-((_FoamTexture_Tint.rgb*_FoamTexture_var.rgb)*(1.0 - saturate((sceneZ-partZ)/_FoamRange))*1.0)))), _Foam );
                indirectDiffuse += _Foam_var; // Diffuse Ambient Light
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuseColor = _Foam_var;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,_WaterTint.a);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _WaterTint;
            uniform float _WaveIntensity;
            uniform sampler2D _FoamTexture; uniform float4 _FoamTexture_ST;
            uniform float _FoamRange;
            uniform float _DarknessDistance;
            uniform float4 _FoamTexture_Tint;
            uniform float _WaveSpeed;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Gloss;
            uniform float _Specular;
            uniform float _Speed;
            uniform fixed _Foam;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 projPos : TEXCOORD7;
                LIGHTING_COORDS(8,9)
                UNITY_FOG_COORDS(10)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float2 node_851_skew = o.uv0 + 0.2127+o.uv0.x*0.3713*o.uv0.y;
                float2 node_851_rnd = 4.789*sin(489.123*(node_851_skew));
                float node_851 = frac(node_851_rnd.x*node_851_rnd.y*(1+node_851_skew.x));
                float4 node_8644 = _Time;
                v.vertex.xyz += float3((float2(0.5,sin((node_851*node_8644.g*_WaveSpeed)))*_WaveIntensity),0.0);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_9780 = _Time;
                float2 node_8291 = (i.uv0+(float2(_Speed,_Speed)*node_9780.g));
                float3 node_7857 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_8291, _NormalMap)));
                float3 node_8838 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = saturate(( node_8838.rgb > 0.5 ? (1.0-(1.0-2.0*(node_8838.rgb-0.5))*(1.0-node_7857.rgb)) : (2.0*node_8838.rgb*node_7857.rgb) ));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularColor = float3(_Specular,_Specular,_Specular);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float node_3574 = (1.0 - saturate((sceneZ-partZ)/_DarknessDistance));
                float node_3848 = 0.3;
                float node_5876_if_leA = step(node_3574,node_3848);
                float node_5876_if_leB = step(node_3848,node_3574);
                float3 node_306 = (lerp((node_5876_if_leA*node_3848)+(node_5876_if_leB*node_3574),node_3848,node_5876_if_leA*node_5876_if_leB)*_WaterTint.rgb);
                float4 _FoamTexture_var = tex2D(_FoamTexture,TRANSFORM_TEX(i.uv0, _FoamTexture));
                float3 _Foam_var = lerp( node_306, saturate((1.0-(1.0-node_306)*(1.0-((_FoamTexture_Tint.rgb*_FoamTexture_var.rgb)*(1.0 - saturate((sceneZ-partZ)/_FoamRange))*1.0)))), _Foam );
                float3 diffuseColor = _Foam_var;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * _WaterTint.a,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _WaveIntensity;
            uniform float _WaveSpeed;
            struct VertexInput {
                float4 vertex : POSITION;
                float4 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float4 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float4 posWorld : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                float2 node_851_skew = o.uv0 + 0.2127+o.uv0.x*0.3713*o.uv0.y;
                float2 node_851_rnd = 4.789*sin(489.123*(node_851_skew));
                float node_851 = frac(node_851_rnd.x*node_851_rnd.y*(1+node_851_skew.x));
                float4 node_8644 = _Time;
                v.vertex.xyz += float3((float2(0.5,sin((node_851*node_8644.g*_WaveSpeed)))*_WaveIntensity),0.0);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _WaterTint;
            uniform float _WaveIntensity;
            uniform sampler2D _FoamTexture; uniform float4 _FoamTexture_ST;
            uniform float _FoamRange;
            uniform float _DarknessDistance;
            uniform float4 _FoamTexture_Tint;
            uniform float _WaveSpeed;
            uniform float _Gloss;
            uniform float _Specular;
            uniform fixed _Foam;
            struct VertexInput {
                float4 vertex : POSITION;
                float4 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float4 projPos : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                float2 node_851_skew = o.uv0 + 0.2127+o.uv0.x*0.3713*o.uv0.y;
                float2 node_851_rnd = 4.789*sin(489.123*(node_851_skew));
                float node_851 = frac(node_851_rnd.x*node_851_rnd.y*(1+node_851_skew.x));
                float4 node_8644 = _Time;
                v.vertex.xyz += float3((float2(0.5,sin((node_851*node_8644.g*_WaveSpeed)))*_WaveIntensity),0.0);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : SV_Target {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float node_3574 = (1.0 - saturate((sceneZ-partZ)/_DarknessDistance));
                float node_3848 = 0.3;
                float node_5876_if_leA = step(node_3574,node_3848);
                float node_5876_if_leB = step(node_3848,node_3574);
                float3 node_306 = (lerp((node_5876_if_leA*node_3848)+(node_5876_if_leB*node_3574),node_3848,node_5876_if_leA*node_5876_if_leB)*_WaterTint.rgb);
                float4 _FoamTexture_var = tex2D(_FoamTexture,TRANSFORM_TEX(i.uv0, _FoamTexture));
                float3 _Foam_var = lerp( node_306, saturate((1.0-(1.0-node_306)*(1.0-((_FoamTexture_Tint.rgb*_FoamTexture_var.rgb)*(1.0 - saturate((sceneZ-partZ)/_FoamRange))*1.0)))), _Foam );
                float3 diffColor = _Foam_var;
                float3 specColor = float3(_Specular,_Specular,_Specular);
                float roughness = 1.0 - _Gloss;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
