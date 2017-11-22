// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Jey/02_SecondShader"
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
				float4 vert(float4 v: POSITION):SV_POSITION
				{
					return UnityObjectToClipPos(v);
				}

				fixed4 frag():SV_Target
				{
					return fixed4(0.5,1,1,1);
				}
				
			ENDCG
		}
	}

	Fallback "VertexLit"
}