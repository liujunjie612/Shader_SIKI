Shader "Jey/01_FirstShader"
{
	Properties
	{
		//属性
		_Color("Color", Color) = (1,1,1,1)
		_Vector("Vector", Vector) = (1,2,3,4)
		_Int("Int", Int) = 2
		_Float("Float", Float) = 3.5
		_Range("Range", Range(1,3)) = 2

		_Texture2D("Texture2D", 2D) = "white"{}
		_Cube("Cube", Cube) = "white"{}
		_Texture3D("Texture3D", 3D) = "white"{}
	}

	//SubShader可以有很多个 显卡运行的时候，从第一个SubShader里面的效果可以实现，那么就使用第一个SubShader，如果显卡这个SubShader里面的某些效果它实现不了，它就会自动运行下个SubShader
	SubShader
	{
		//至少一个Pass
		Pass
		{
			//在这里编写Shader代码  HLSLPEOGRAM
			CGPROGRAM
			//使用CG语言编写Shader代码
			float4  _Color;  //float 可用half或者fixed代替       float 32位    half 16位（-6万 - 6万）  fixed 11位（-2 - 2）
			float4 _Vector;
			float _Int;
			float _Float;
			float _Range;

			sampler2D _Texture2D;
			samplerCube _Cube;
			sampler _Texture3D;

			ENDCG

		}
	}

	Fallback "VertexLit"
}	