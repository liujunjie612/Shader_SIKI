// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Jey/03_UseStruct"
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
					float3 normal: NORMAL; //告诉Unity把模型空间下的法线填充给normal
					float4 texcoord: TEXCOORD0; //告诉Unity把第一套纹理坐标填充给texcoord
				};

				struct v2f
				{
					float4 position: SV_POSITION;
					float3 temp: COLOR0;
				};

				 
				v2f vert(a2v v)
				{
					v2f f;
					f.position = UnityObjectToClipPos(v.v1);
					f.temp = v.normal;
					return f;
				}

				fixed4 frag(v2f f):SV_Target
				{
					return fixed4(f.temp,1);
				}
				
			ENDCG
		}
	}

	Fallback "VertexLit"
}