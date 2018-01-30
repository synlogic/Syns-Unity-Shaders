// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33486,y:32294,varname:node_3138,prsc:2|custl-313-OUT;n:type:ShaderForge.SFN_Tex2d,id:7464,x:32701,y:32641,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_7464,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:6405,x:32701,y:32828,ptovrint:False,ptlb:Secondary,ptin:_Secondary,varname:node_6405,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Time,id:984,x:32028,y:32397,varname:node_984,prsc:2;n:type:ShaderForge.SFN_Sin,id:6579,x:32449,y:32323,varname:node_6579,prsc:2|IN-7880-OUT;n:type:ShaderForge.SFN_Multiply,id:803,x:32230,y:32359,varname:node_803,prsc:2|A-2125-OUT,B-984-T;n:type:ShaderForge.SFN_ValueProperty,id:2125,x:32028,y:32339,ptovrint:False,ptlb:speed,ptin:_speed,varname:node_2125,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Slider,id:1976,x:32421,y:32213,ptovrint:False,ptlb:ramp,ptin:_ramp,varname:node_1976,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Color,id:2109,x:33084,y:32373,ptovrint:False,ptlb:Tint,ptin:_Tint,varname:node_2109,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:313,x:33304,y:32532,varname:node_313,prsc:2|A-2109-RGB,B-2070-OUT,C-8657-OUT;n:type:ShaderForge.SFN_Multiply,id:3413,x:32915,y:32531,varname:node_3413,prsc:2|A-2814-OUT,B-7464-RGB;n:type:ShaderForge.SFN_Add,id:7880,x:32230,y:32213,varname:node_7880,prsc:2|A-6585-V,B-803-OUT;n:type:ShaderForge.SFN_ScreenPos,id:6585,x:32028,y:32158,varname:node_6585,prsc:2,sctp:0;n:type:ShaderForge.SFN_OneMinus,id:9126,x:32701,y:32478,varname:node_9126,prsc:2|IN-6579-OUT;n:type:ShaderForge.SFN_Multiply,id:4700,x:32915,y:32719,varname:node_4700,prsc:2|A-9126-OUT,B-6405-RGB;n:type:ShaderForge.SFN_Blend,id:2070,x:33122,y:32667,varname:node_2070,prsc:2,blmd:5,clmp:True|SRC-3413-OUT,DST-4700-OUT;n:type:ShaderForge.SFN_Divide,id:2814,x:32834,y:32322,varname:node_2814,prsc:2|A-1976-OUT,B-6579-OUT;n:type:ShaderForge.SFN_Multiply,id:3027,x:33174,y:32938,varname:node_3027,prsc:2|A-6436-RGB,B-9514-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:9514,x:32915,y:33048,varname:node_9514,prsc:2;n:type:ShaderForge.SFN_LightColor,id:6436,x:32915,y:32928,varname:node_6436,prsc:2;n:type:ShaderForge.SFN_Vector3,id:6859,x:33345,y:32830,varname:node_6859,prsc:2,v1:0.5,v2:0.5,v3:0.5;n:type:ShaderForge.SFN_Add,id:8657,x:33494,y:32917,varname:node_8657,prsc:2|A-6859-OUT,B-3027-OUT;proporder:7464-6405-2125-1976-2109;pass:END;sub:END;*/

Shader "SynLogic/ScanLine" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Secondary ("Secondary", 2D) = "white" {}
        _speed ("speed", Float ) = 1
        _ramp ("ramp", Range(0, 1)) = 0.5
        _Tint ("Tint", Color) = (1,1,1,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _Secondary; uniform float4 _Secondary_ST;
            uniform float _speed;
            uniform float _ramp;
            uniform float4 _Tint;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 node_984 = _Time;
                float node_6579 = sin(((sceneUVs * 2 - 1).g+(_speed*node_984.g)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 _Secondary_var = tex2D(_Secondary,TRANSFORM_TEX(i.uv0, _Secondary));
                float3 node_6859 = float3(0.5,0.5,0.5);
                float3 node_3027 = (_LightColor0.rgb*attenuation);
                float3 finalColor = (_Tint.rgb*saturate(max(((_ramp/node_6579)*_MainTex_var.rgb),((1.0 - node_6579)*_Secondary_var.rgb)))*(node_6859+node_3027));
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _Secondary; uniform float4 _Secondary_ST;
            uniform float _speed;
            uniform float _ramp;
            uniform float4 _Tint;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 node_984 = _Time;
                float node_6579 = sin(((sceneUVs * 2 - 1).g+(_speed*node_984.g)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 _Secondary_var = tex2D(_Secondary,TRANSFORM_TEX(i.uv0, _Secondary));
                float3 node_6859 = float3(0.5,0.5,0.5);
                float3 node_3027 = (_LightColor0.rgb*attenuation);
                float3 finalColor = (_Tint.rgb*saturate(max(((_ramp/node_6579)*_MainTex_var.rgb),((1.0 - node_6579)*_Secondary_var.rgb)))*(node_6859+node_3027));
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
