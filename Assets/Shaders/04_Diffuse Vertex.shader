// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Jey/04_Diffuse Vertex"
{

	SubShader
	{
		Pass
		{
			CGPROGRAM

			//顶点函数，这里只是声明了顶点函数的函数名：把顶点坐标从模型空间转换成剪裁空间
			#pragma vertex vert

			//片元函数，这里只是声明了片元函数的函数名：返回模型对应的屏幕上每个像素的颜色值
			#pragma fragment frag

				//application to vertex
				struct a2v
				{
					float4 v1: POSITION; //告诉Unity把模型空间下的顶点填充给vertex
				};

				struct v2f
				{
					float4 position: SV_POSITION;
				};

				 
				v2f vert(a2v v)
				{
					v2f f;
					f.position = UnityObjectToClipPos(v.v1);
					return f;
				}

				fixed4 frag():SV_Target
				{
					return fixed4(1,1,1,1);
				}
				
			ENDCG
		}
	}

	Fallback "VertexLit"
}