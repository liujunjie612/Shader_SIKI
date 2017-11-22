// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Jey/04_Diffuse Vertex"
{

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

				//application to vertex
				struct a2v
				{
					float4 v1: POSITION; //告诉Unity把模型空间下的顶点填充给vertex
					float3 normal: NORMAL;
				};

				struct v2f
				{
					float4 position: SV_POSITION;
					fixed3 color: COLOR;
				};

				 
				v2f vert(a2v v)
				{
					v2f f;
					f.position = UnityObjectToClipPos(v.v1);

					fixed3 normalDir = normalize(mul(v.normal,(float3x3)unity_WorldToObject));

					fixed lightDir = _WorldSpaceLightPos0.xyz; //对于每个顶点，光的位置就是光的方向（光是平行光）

					fixed3 diffuse = _LightColor0.rgb * max(dot(normalDir, lightDir), 0); //取得漫反射颜色
					f.color = diffuse;
					return f;
				}

				fixed4 frag(v2f f):SV_Target
				{
					return fixed4(f.color,1);
				}
				
			ENDCG
		}
	}

	Fallback "VertexLit"
}