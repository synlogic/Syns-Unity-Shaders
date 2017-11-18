// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33640,y:32683,varname:node_3138,prsc:2|custl-5211-OUT,olwid-9241-OUT,olcol-7145-OUT;n:type:ShaderForge.SFN_Tex2d,id:4643,x:32551,y:32942,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_4643,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_FragmentPosition,id:2836,x:32391,y:32852,varname:node_2836,prsc:2;n:type:ShaderForge.SFN_Distance,id:2314,x:32558,y:32723,varname:node_2314,prsc:2|A-4902-XYZ,B-2836-XYZ;n:type:ShaderForge.SFN_ViewPosition,id:4902,x:32391,y:32723,varname:node_4902,prsc:2;n:type:ShaderForge.SFN_If,id:5248,x:32887,y:32904,varname:node_5248,prsc:2|A-2314-OUT,B-327-OUT,GT-7647-OUT,EQ-7647-OUT,LT-4643-RGB;n:type:ShaderForge.SFN_Blend,id:7647,x:32729,y:33066,varname:node_7647,prsc:2,blmd:1,clmp:True|SRC-4643-RGB,DST-5209-RGB;n:type:ShaderForge.SFN_ValueProperty,id:327,x:32558,y:32866,ptovrint:False,ptlb:Distance,ptin:_Distance,varname:node_327,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Color,id:5209,x:32729,y:33273,ptovrint:False,ptlb:Color1,ptin:_Color1,varname:node_5209,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.751724,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:7573,x:32954,y:33262,ptovrint:False,ptlb:Color2,ptin:_Color2,varname:node_7573,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Color,id:8472,x:33185,y:33262,ptovrint:False,ptlb:Color3,ptin:_Color3,varname:node_8472,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2413793,c2:1,c3:0,c4:1;n:type:ShaderForge.SFN_If,id:1869,x:33102,y:32904,varname:node_1869,prsc:2|A-2314-OUT,B-6627-OUT,GT-4688-OUT,EQ-4688-OUT,LT-5248-OUT;n:type:ShaderForge.SFN_Code,id:6627,x:32726,y:32713,varname:node_6627,prsc:2,code:ZgBsAG8AYQB0ACAAbgBlAHcASQBuAHAAdQB0ACAAPQAgAGkAbgBwAHUAdAAgACoAIAAyADsACgByAGUAdAB1AHIAbgAgAG4AZQB3AEkAbgBwAHUAdAA7AA==,output:0,fname:DistanceTimesTwo,width:247,height:132,input:0,input_1_label:input|A-327-OUT;n:type:ShaderForge.SFN_Blend,id:4688,x:32954,y:33066,varname:node_4688,prsc:2,blmd:1,clmp:True|SRC-4643-RGB,DST-7573-RGB;n:type:ShaderForge.SFN_Blend,id:5827,x:33185,y:33066,varname:node_5827,prsc:2,blmd:1,clmp:True|SRC-4643-RGB,DST-8472-RGB;n:type:ShaderForge.SFN_If,id:5211,x:33451,y:32896,varname:node_5211,prsc:2|A-2314-OUT,B-8179-OUT,GT-5827-OUT,EQ-5827-OUT,LT-1869-OUT;n:type:ShaderForge.SFN_Code,id:8179,x:33042,y:32718,varname:node_8179,prsc:2,code:ZgBsAG8AYQB0ACAAbgBlAHcASQBuAHAAdQB0ACAAPQAgAEQAaQBzAHQAYQBuAGMAZQBUAGkAbQBlAHMAVAB3AG8AKABpAG4AcAB1AHQAKQA7AAoAcgBlAHQAdQByAG4AIABuAGUAdwBJAG4AcAB1AHQAOwA=,output:0,fname:DistancesTimesTwo_Callback,width:254,height:124,input:0,input_1_label:input|A-6627-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9241,x:33451,y:33049,ptovrint:False,ptlb:OutlineWidth,ptin:_OutlineWidth,varname:node_9241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.0001;n:type:ShaderForge.SFN_Slider,id:1642,x:33372,y:33235,ptovrint:False,ptlb:Outline Tint,ptin:_OutlineTint,varname:node_1642,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:7145,x:33745,y:33244,varname:node_7145,prsc:2|A-1642-OUT,B-5211-OUT;proporder:4643-327-5209-7573-8472-9241-1642;pass:END;sub:END;*/

Shader "SynLogic/DistanceColorSwap" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Distance ("Distance", Float ) = 0.5
        _Color1 ("Color1", Color) = (0,0.751724,1,1)
        _Color2 ("Color2", Color) = (1,0,0,1)
        _Color3 ("Color3", Color) = (0.2413793,1,0,1)
        _OutlineWidth ("OutlineWidth", Float ) = 0.0001
        _OutlineTint ("Outline Tint", Range(0, 1)) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Distance;
            uniform float4 _Color1;
            uniform float4 _Color2;
            uniform float4 _Color3;
            float DistanceTimesTwo( float input ){
            float newInput = input * 2;
            return newInput;
            }
            
            float DistancesTimesTwo_Callback( float input ){
            float newInput = DistanceTimesTwo(input);
            return newInput;
            }
            
            uniform float _OutlineWidth;
            uniform float _OutlineTint;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_OutlineWidth,1) );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float node_2314 = distance(_WorldSpaceCameraPos,i.posWorld.rgb);
                float node_6627 = DistanceTimesTwo( _Distance );
                float node_5211_if_leA = step(node_2314,DistancesTimesTwo_Callback( node_6627 ));
                float node_5211_if_leB = step(DistancesTimesTwo_Callback( node_6627 ),node_2314);
                float node_1869_if_leA = step(node_2314,node_6627);
                float node_1869_if_leB = step(node_6627,node_2314);
                float node_5248_if_leA = step(node_2314,_Distance);
                float node_5248_if_leB = step(_Distance,node_2314);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 node_7647 = saturate((_MainTex_var.rgb*_Color1.rgb));
                float3 node_4688 = saturate((_MainTex_var.rgb*_Color2.rgb));
                float3 node_5827 = saturate((_MainTex_var.rgb*_Color3.rgb));
                float3 node_5211 = lerp((node_5211_if_leA*lerp((node_1869_if_leA*lerp((node_5248_if_leA*_MainTex_var.rgb)+(node_5248_if_leB*node_7647),node_7647,node_5248_if_leA*node_5248_if_leB))+(node_1869_if_leB*node_4688),node_4688,node_1869_if_leA*node_1869_if_leB))+(node_5211_if_leB*node_5827),node_5827,node_5211_if_leA*node_5211_if_leB);
                return fixed4((_OutlineTint*node_5211),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Distance;
            uniform float4 _Color1;
            uniform float4 _Color2;
            uniform float4 _Color3;
            float DistanceTimesTwo( float input ){
            float newInput = input * 2;
            return newInput;
            }
            
            float DistancesTimesTwo_Callback( float input ){
            float newInput = DistanceTimesTwo(input);
            return newInput;
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
                float node_2314 = distance(_WorldSpaceCameraPos,i.posWorld.rgb);
                float node_6627 = DistanceTimesTwo( _Distance );
                float node_5211_if_leA = step(node_2314,DistancesTimesTwo_Callback( node_6627 ));
                float node_5211_if_leB = step(DistancesTimesTwo_Callback( node_6627 ),node_2314);
                float node_1869_if_leA = step(node_2314,node_6627);
                float node_1869_if_leB = step(node_6627,node_2314);
                float node_5248_if_leA = step(node_2314,_Distance);
                float node_5248_if_leB = step(_Distance,node_2314);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 node_7647 = saturate((_MainTex_var.rgb*_Color1.rgb));
                float3 node_4688 = saturate((_MainTex_var.rgb*_Color2.rgb));
                float3 node_5827 = saturate((_MainTex_var.rgb*_Color3.rgb));
                float3 node_5211 = lerp((node_5211_if_leA*lerp((node_1869_if_leA*lerp((node_5248_if_leA*_MainTex_var.rgb)+(node_5248_if_leB*node_7647),node_7647,node_5248_if_leA*node_5248_if_leB))+(node_1869_if_leB*node_4688),node_4688,node_1869_if_leA*node_1869_if_leB))+(node_5211_if_leB*node_5827),node_5827,node_5211_if_leA*node_5211_if_leB);
                float3 finalColor = node_5211;
                return fixed4(finalColor,1);
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
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
