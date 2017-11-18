// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33566,y:32680,varname:node_3138,prsc:2|custl-4828-OUT,olwid-801-OUT,olcol-6655-OUT;n:type:ShaderForge.SFN_Tex2d,id:3391,x:32908,y:32939,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_3391,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:beb3bd9f5758c734ba00aacba718696c,ntxv:0,isnm:False;n:type:ShaderForge.SFN_LightColor,id:1067,x:32475,y:32853,varname:node_1067,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:9935,x:32475,y:32720,varname:node_9935,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5132,x:32708,y:32853,varname:node_5132,prsc:2|A-9935-OUT,B-1067-RGB;n:type:ShaderForge.SFN_Add,id:2097,x:32908,y:32787,varname:node_2097,prsc:2|A-4091-RGB,B-5132-OUT;n:type:ShaderForge.SFN_Multiply,id:6712,x:33140,y:32828,varname:node_6712,prsc:2|A-2097-OUT,B-3391-RGB;n:type:ShaderForge.SFN_Multiply,id:4470,x:33142,y:33144,varname:node_4470,prsc:2|A-3391-RGB,B-1373-OUT;n:type:ShaderForge.SFN_Slider,id:1373,x:32751,y:33149,ptovrint:False,ptlb:Tint,ptin:_Tint,varname:node_1373,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:801,x:33116,y:33012,ptovrint:False,ptlb:Outline Width,ptin:_OutlineWidth,varname:node_801,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.001;n:type:ShaderForge.SFN_Color,id:4091,x:32708,y:32696,ptovrint:False,ptlb:Shadow Tint,ptin:_ShadowTint,varname:node_4091,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_TexCoord,id:752,x:32706,y:32389,varname:node_752,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Rotator,id:5631,x:32919,y:32420,varname:node_5631,prsc:2|UVIN-752-UVOUT,SPD-2558-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2558,x:32706,y:32565,ptovrint:False,ptlb:Rotate Speed,ptin:_RotateSpeed,varname:node_2558,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:9998,x:33120,y:32440,ptovrint:False,ptlb:Overlay Texture,ptin:_OverlayTexture,varname:node_9998,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7af06849277e8ce4bae935afac2eba1c,ntxv:0,isnm:False|UVIN-5631-UVOUT;n:type:ShaderForge.SFN_Blend,id:4828,x:33350,y:32630,varname:node_4828,prsc:2,blmd:6,clmp:True|SRC-9998-RGB,DST-6712-OUT;n:type:ShaderForge.SFN_Add,id:6655,x:33402,y:33106,varname:node_6655,prsc:2|A-9998-RGB,B-4470-OUT;proporder:3391-1373-801-4091-2558-9998;pass:END;sub:END;*/

Shader "SynLogic/TextureOverlay" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Tint ("Tint", Range(0, 1)) = 0
        _OutlineWidth ("Outline Width", Range(0, 0.001)) = 0
        _ShadowTint ("Shadow Tint", Color) = (0.5,0.5,0.5,1)
        _RotateSpeed ("Rotate Speed", Float ) = 1
        _OverlayTexture ("Overlay Texture", 2D) = "white" {}
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
            uniform float _Tint;
            uniform float _OutlineWidth;
            uniform float _RotateSpeed;
            uniform sampler2D _OverlayTexture; uniform float4 _OverlayTexture_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_OutlineWidth,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 node_491 = _Time;
                float node_5631_ang = node_491.g;
                float node_5631_spd = _RotateSpeed;
                float node_5631_cos = cos(node_5631_spd*node_5631_ang);
                float node_5631_sin = sin(node_5631_spd*node_5631_ang);
                float2 node_5631_piv = float2(0.5,0.5);
                float2 node_5631 = (mul(i.uv0-node_5631_piv,float2x2( node_5631_cos, -node_5631_sin, node_5631_sin, node_5631_cos))+node_5631_piv);
                float4 _OverlayTexture_var = tex2D(_OverlayTexture,TRANSFORM_TEX(node_5631, _OverlayTexture));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                return fixed4((_OverlayTexture_var.rgb+(_MainTex_var.rgb*_Tint)),0);
            }
            ENDCG
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
            uniform float4 _ShadowTint;
            uniform float _RotateSpeed;
            uniform sampler2D _OverlayTexture; uniform float4 _OverlayTexture_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                LIGHTING_COORDS(1,2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 node_6177 = _Time;
                float node_5631_ang = node_6177.g;
                float node_5631_spd = _RotateSpeed;
                float node_5631_cos = cos(node_5631_spd*node_5631_ang);
                float node_5631_sin = sin(node_5631_spd*node_5631_ang);
                float2 node_5631_piv = float2(0.5,0.5);
                float2 node_5631 = (mul(i.uv0-node_5631_piv,float2x2( node_5631_cos, -node_5631_sin, node_5631_sin, node_5631_cos))+node_5631_piv);
                float4 _OverlayTexture_var = tex2D(_OverlayTexture,TRANSFORM_TEX(node_5631, _OverlayTexture));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 finalColor = saturate((1.0-(1.0-_OverlayTexture_var.rgb)*(1.0-((_ShadowTint.rgb+(attenuation*_LightColor0.rgb))*_MainTex_var.rgb))));
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
            uniform float4 _ShadowTint;
            uniform float _RotateSpeed;
            uniform sampler2D _OverlayTexture; uniform float4 _OverlayTexture_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                LIGHTING_COORDS(1,2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 node_900 = _Time;
                float node_5631_ang = node_900.g;
                float node_5631_spd = _RotateSpeed;
                float node_5631_cos = cos(node_5631_spd*node_5631_ang);
                float node_5631_sin = sin(node_5631_spd*node_5631_ang);
                float2 node_5631_piv = float2(0.5,0.5);
                float2 node_5631 = (mul(i.uv0-node_5631_piv,float2x2( node_5631_cos, -node_5631_sin, node_5631_sin, node_5631_cos))+node_5631_piv);
                float4 _OverlayTexture_var = tex2D(_OverlayTexture,TRANSFORM_TEX(node_5631, _OverlayTexture));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 finalColor = saturate((1.0-(1.0-_OverlayTexture_var.rgb)*(1.0-((_ShadowTint.rgb+(attenuation*_LightColor0.rgb))*_MainTex_var.rgb))));
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
