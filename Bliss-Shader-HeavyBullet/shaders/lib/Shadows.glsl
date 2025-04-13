// Emin's and Gri's combined ideas to stop peter panning and light leaking, also has little shadowacne so thats nice
// https://www.complementary.dev/reimagined
// https://github.com/gri573
void GriAndEminShadowFix(
	inout vec3 WorldPos,
	vec3 FlatNormal,
	float VanillaAO,
	float SkyLightmap
){
	float minvalue = 0.007;

	#ifdef DISTANT_HORIZONS_SHADOWMAP
		minvalue = 0.035;
	#endif

	float shadowResScale = (2048.0 / shadowMapResolution) / 4.0;
	float DistanceOffset = (length(WorldPos) + 4.0) * (minvalue + shadowResScale * 0.015);

	vec3 Bias = FlatNormal * DistanceOffset;
	vec3 finalBias = Bias;

	vec2 scale = vec2(0.5);
	scale.y *= 0.5;
	vec3 zoomShadow = scale.y - scale.x * fract(WorldPos + cameraPosition + Bias * scale.y);
	if (SkyLightmap < 0.1) finalBias = mix(Bias, zoomShadow, clamp(VanillaAO * 5.0, 0.0, 1.0));

	WorldPos += finalBias;
}

// Dual distortion function for advanced shadow mapping
vec3 dual_distort(vec3 uv1) {
	uv1 = uv1 * 0.5 + 0.5;
	vec2 uv = uv1.xy;

	// Inner and outer distortion factors
	#define DSTR 0.7 //[0.0 1.0]
	#define DHSTR2 0.7 //[0.0 1.0]

	vec2 s = sign(uv - 0.5);
	uv = (uv - 0.5) * 2.0;

	#define FAR 0.5
	float sint = 1.0;
	float sint2 = 1.0;

	float d = (distance((uv / FAR), vec2(0.0)) - 0.5) * 2.0;

	float bf = clamp(((d / FAR) * 0.75) * 4.0, 0.0, 1.0);
	uv = ((1.0 - abs(uv)));

	vec2 uvn = 1.0 - uv * 1.0;
	vec2 uv0 = mix(uvn, pow(uvn, vec2(1.0 / 2.0)), clamp(DSTR * sint2, 0.0, 1.0));
	uv0 = uv0 / (uv0.xy + SHADOW_DISTORT_FACTOR);

	uv.x = pow(1.0 - uv.x, 1.0 / clamp(1.0 + DHSTR2 * sint, 1.0, 9.0));
	uv.y = pow(1.0 - uv.y, 1.0 / clamp(1.0 + DHSTR2 * sint, 1.0, 9.0));
	uv = mix(uv0, uv, bf);

	uv = 0.5 + 0.5 * uv * s;
	uv = uv * 2.0 - 1.0;
	return vec3(uv, uv1.z);
}

// Example usage of dual_distort in shadow calculations
void ApplyDualDistortion(inout vec3 ShadowPos) {
	ShadowPos = dual_distort(ShadowPos);
}