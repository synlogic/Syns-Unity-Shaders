// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33809,y:32864,varname:node_3138,prsc:2|custl-653-OUT,olwid-7608-OUT,olcol-3002-RGB;n:type:ShaderForge.SFN_Tex2d,id:3653,x:32843,y:32813,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_3653,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a79dc5b11061a2a45a7e4bd81636ecc1,ntxv:3,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:7608,x:33440,y:33182,ptovrint:False,ptlb:Outline Width,ptin:_OutlineWidth,varname:node_7608,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.01;n:type:ShaderForge.SFN_Multiply,id:653,x:33481,y:32876,varname:node_653,prsc:2|A-3653-RGB,B-6229-RGB;n:type:ShaderForge.SFN_Multiply,id:9877,x:33030,y:33280,varname:node_9877,prsc:2|A-7796-OUT,B-7673-T;n:type:ShaderForge.SFN_Time,id:7673,x:32843,y:33351,varname:node_7673,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:7674,x:32843,y:33127,varname:node_7674,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:2892,x:33223,y:33280,varname:node_2892,prsc:2|A-7674-UVOUT,B-9877-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7796,x:32843,y:33291,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_7796,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.05;n:type:ShaderForge.SFN_ComponentMask,id:9419,x:33105,y:33058,varname:node_9419,prsc:2,cc1:1,cc2:0,cc3:-1,cc4:-1|IN-7674-UVOUT;n:type:ShaderForge.SFN_Color,id:6229,x:32843,y:32992,ptovrint:False,ptlb:Tint,ptin:_Tint,varname:node_6229,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Hue,id:2707,x:33455,y:33465,varname:node_2707,prsc:2|IN-2892-OUT;n:type:ShaderForge.SFN_Tex2d,id:3002,x:33455,y:33280,ptovrint:False,ptlb:Outline Texture,ptin:_OutlineTexture,varname:node_3002,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7af06849277e8ce4bae935afac2eba1c,ntxv:0,isnm:False|UVIN-2892-OUT;proporder:3653-7608-7796-6229-3002;pass:END;sub:END;*/

Shader "SynLogic/PanningOutlineUnlit" {
    Properties {
        _MainTex ("MainTex", 2D) = "bump" {}
        _OutlineWidth ("Outline Width", Float ) = 0.0001
        _Speed ("Speed", Float ) = 0.05
        _Tint ("Tint", Color) = (1,1,1,1)
        _OutlineTexture ("Outline Texture", 2D) = "white" {}
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
            uniform float _OutlineWidth;
            uniform float _Speed;
            uniform sampler2D _OutlineTexture; uniform float4 _OutlineTexture_ST;
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 node_7673 = _Time;
                float2 node_2892 = (i.uv0+(_Speed*node_7673.g));
                float4 _OutlineTexture_var = tex2D(_OutlineTexture,TRANSFORM_TEX(node_2892, _OutlineTexture));
                return fixed4(_OutlineTexture_var.rgb,0);
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
            uniform float4 _Tint;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 finalColor = (_MainTex_var.rgb*_Tint.rgb);
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
