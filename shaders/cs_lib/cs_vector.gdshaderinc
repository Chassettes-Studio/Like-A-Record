bool check_uv(vec2 uv){
    return uv.x >= 0. && uv.y >= 0. && uv.x <= 1. && uv.y <= 1. ;
}

vec2 rotate(vec2 v, float a){
	return vec2(v.x * cos(a) - v.y * sin(a), v.x * sin(a) + v.y * cos(a));
}

vec2 project2(vec2 v, vec2 on){
	return normalize(on) * dot(on,v);
}

float angle2(vec2 v){
	if (v.x == 0.) {
		return PI*v.y/abs(v.y);
	}
	return atan(v.x/v.y);
}


