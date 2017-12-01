// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Jey/08_Specular Fragment"
{

	Properties
	{
		_Diffuse("Diffuse Color",Color) = (1,1,1,1)
		_Gloss("Gloss", Range(8,200)) = 10
		_SpecularColor("Specular Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM

			#include "Lighting.cginc"  //取得第一个直射光的颜色 _LightColor0, 第一个直射光的位置 _WorldSpaceLightPos0

			//顶点函数，这里只是声明了顶点函数的函数名：把顶点坐标从模型空间转换成剪裁空间
			#pragma vertex vert

			//片元函数，这里只是声明了片元函数的函数名：返回模型对应的屏幕上每个像素的颜色值
			#pragma fragment frag

				fixed4 _Diffuse;
				half _Gloss;
				fixed4 _SpecularColor;

				//application to vertex
				struct a2v
				{
					float4 v1: POSITION; //告诉Unity把模型空间下的顶点填充给vertex
					float3 normal: NORMAL;
				};

				struct v2f
				{
					float4 position: SV_POSITION;
					float3 worldNormal: TEXCOORD0;
					float3 worldVertex: TEXCOORD1;
				};

				 
				v2f vert(a2v v)
				{
					v2f f; 
					f.position = UnityObjectToClipPos(v.v1);
					f.worldNormal = mul(v.normal,(float3x3)unity_WorldToObject);
					f.worldVertex = mul(v.v1, unity_WorldToObject).xyz;
					return f;
				}

				fixed4 frag(v2f f):SV_Target
				{
					fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;  //系统环境光

					fixed3 normalDir = normalize(f.worldNormal);

					fixed lightDir = normalize(_WorldSpaceLightPos0.xyz); //对于每个顶点，光的位置就是光的方向（光是平行光）

					fixed3 diffuse = _LightColor0.rgb * max(dot(normalDir, lightDir), 0) * _Diffuse.rgb; //取得漫反射颜色

					fixed3 reflectDir = normalize(reflect(-lightDir, normalDir));

					fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - f.worldVertex);
					fixed3 specular = _SpecularColor.rgb * pow(max(dot(reflectDir, viewDir) ,0), _Gloss);

					fixed3 tempColor = diffuse + ambient + specular;

					return fixed4(tempColor,1);
				}
				
			ENDCG
		}
	}

	Fallback "Diffuse"
}