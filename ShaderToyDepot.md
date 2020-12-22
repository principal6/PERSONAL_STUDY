# ShaderToy Depot



## Basic Shapes

```glsl
bool roundedRect(in vec2 p, in vec2 c, in vec2 s, in float r)
{
    vec2 hs = s / 2.0;
    float a = (min(s.x, s.y) / 2.0) * r;
    vec2 offset = p - c + hs;
    if (0.0 < offset.x && offset.x < s.x &&
        0.0 < offset.y && offset.y < s.y)
    {
        bool isBottom = offset.y < a;
        bool isTop = s.y - a < offset.y;
        
        // left
        if (offset.x < a && (isBottom == true || isTop == true))
        {
            float d = distance(vec2(a, (isTop) ? s.y - a : a), offset);
            if (a < d)
            {
                return false;
            }
        }
        
        // right
        if (s.x - a < offset.x && (isBottom == true || isTop == true))
        {
            float d = distance(vec2(s.x - a, (isTop) ? s.y - a : a), offset);
            if (a < d)
            {
                return false;
            }
        }
        return true;
    }
    return false;
}

bool taperedRect(in vec2 p, in vec2 c, in vec2 s, in float t, in float b)
{
    vec2 hs = s / 2.0;
    vec2 offset = p - c + hs;
    if (0.0 < offset.x && offset.x < s.x &&
        0.0 < offset.y && offset.y < s.y)
    {
		t = clamp(t, 0.0, 1.0);
		b = clamp(b, 0.0, 1.0);
		
        float Msw = s.x * (1.0 - t); // max space width
        float Mtx = Msw * b;         // max tapering x offset
        
        float hr = (offset.y / s.y); // height ratio = [0.0, 1.0]
        float lt = t * hr;           // lerped t = [0.0, t]
		float lMtx = Mtx * hr;       // lerped tapering x offset
        float ltw = s.x * lt;        // lerped tapered width
        
        if ((lMtx < offset.x) && (offset.x + ltw - lMtx < s.x))
        {
            return true;
        }
        
        return false;
    }
    return false;
}

const float kLineThicknessFactor = 0.002;
bool bluntLine(in vec2 p, in vec2 l0, in vec2 l1, in float th)
{
    float fth = kLineThicknessFactor * th; // factored thickness
    vec2 ls = l1 - l0;                     // line segment
    vec2 ld = normalize(ls);
    vec2 p0 = p - l0;
	float t = dot(p0, ld);
	vec2 lp = l0 + ld * t;
    
    float lsl = length(ls);
    if ((t < 0.0) || (lsl < t))
    {
        float d0 = distance(p, (t < 0.0) ? l0 : l1);
        if (fth <= d0)
        {
            return false;
        }
    }
    
    float dist = distance(lp, p);
	if (dist < fth)
	{
		return true;
	}
    return false;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 p = fragCoord/iResolution.xy;
    p *= 2.0;
    p -= vec2(1.0, 1.0);

    float sr = float(iResolution.x) / iResolution.y;
    p.y = p.y / sr;
    
    vec3 col = vec3(1.0, 1.0, 1.0);
    if (roundedRect(p, vec2(0.0, 0.0), vec2(0.5, 0.25), 0.25) == true)
    {
        col = vec3(1.0, 0.0, 0.0);
    }
    if (taperedRect(p, vec2(0.0, 0.3125), vec2(0.5, 0.25), 0.5, 1.0) == true)
    {
        col = vec3(1.0, 0.25, 0.0);
    }
	if (bluntLine(p, vec2(-0.5, 0.0), vec2(0.5, 0.5), 2.0) == true)
    {
        col = vec3(0.0, 0.25, 1.0);
    }
    fragColor = vec4(col,1.0);
}
```

