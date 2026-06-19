#include "cs_vector.gdshaderinc"

float sdf(vec2 uv, vec2 pixel_size, sampler2D source_texture, float threshold, int linear_steps, float linear_range, int angular_steps) {
	float base_alpha = texture(source_texture,uv).a;
	vec2 pixel_uv = uv/pixel_size;
	float dezoom_step = linear_range/float(linear_steps);
	for(float dezoom = 1.; dezoom <= linear_range; dezoom += dezoom_step){
		float angle_increment = 2.*PI/float(angular_steps);
		vec2 offset = vec2(float(dezoom),0.);
		for(float angle = 0.; angle < 2.*PI; angle += angle_increment){
			vec2 pixel_offset = rotate(offset,angle);
			vec2 new_uv = (pixel_offset + pixel_uv)*pixel_size;
			float new_alpha = 0.;
			if(check_uv(new_uv)){
				new_alpha = texture(source_texture, new_uv).a;
				
			}
			
			if( (base_alpha > threshold && new_alpha <= threshold) || (base_alpha <= threshold && new_alpha > threshold) ){
				return base_alpha > threshold ? - dezoom : dezoom; 
			}
		}
	}
	return base_alpha > threshold ? - linear_range : linear_range;
	
}
