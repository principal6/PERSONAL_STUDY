# ShaderToy Depot

## Basic Shapes

```glsl
bool roundedRect(in vec2 pixelPosition, in vec2 size, in float roundness)
{
    vec2 hs = size / 2.0;
    vec2 offset = pixelPosition + hs;
    if (0.0 < offset.x && offset.x < size.x &&
        0.0 < offset.y && offset.y < size.y)
    {
        float a = (min(size.x, size.y) / 2.0) * roundness;
        bool isBottom = offset.y < a;
        bool isTop = size.y - a < offset.y;
        
        // left
        if (offset.x < a && (isBottom == true || isTop == true))
        {
            float d = distance(vec2(a, (isTop) ? size.y - a : a), offset);
            if (a < d)
            {
                return false;
            }
        }
        
        // right
        if (size.x - a < offset.x && (isBottom == true || isTop == true))
        {
            float d = distance(vec2(size.x - a, (isTop) ? size.y - a : a), offset);
            if (a < d)
            {
                return false;
            }
        }
        return true;
    }
    return false;
}

bool taperedRect(in vec2 pixelPosition, in vec2 size, in float tapering, in float bias)
{
    vec2 hs = size / 2.0;
    vec2 offset = pixelPosition + hs;
    if (0.0 < offset.x && offset.x < size.x &&
        0.0 < offset.y && offset.y < size.y)
    {
		tapering = clamp(tapering, 0.0, 1.0);
		bias = clamp(bias, 0.0, 1.0);
		
        float Msw = size.x * (1.0 - tapering); // max space width
        float Mtx = Msw * bias;                // max tapering x offset
        
        float hr = (offset.y / size.y); // height ratio = [0.0, 1.0]
        float lt = tapering * hr;       // lerped tapering = [0.0, tapering]
		float lMtx = Mtx * hr;          // lerped tapering x offset
        float ltw = size.x * lt;        // lerped tapered width
        
        if ((lMtx < offset.x) && (offset.x + ltw - lMtx < size.x))
        {
            return true;
        }
        
        return false;
    }
    return false;
}

const float kLineThicknessFactor = 0.002;
bool bluntLine(in vec2 pixelPosition, in vec2 l0, in vec2 l1, in float thickness)
{
    float fth = kLineThicknessFactor * thickness; // factored thickness
    vec2 segment = l1 - l0;                       // line segment
    vec2 direction = normalize(segment);
    vec2 p0 = pixelPosition - l0;
	float t = dot(p0, direction);
	vec2 lp = l0 + direction * t;
    
    float lsl = length(segment);
    if ((t < 0.0) || (lsl < t))
    {
        float d0 = distance(pixelPosition, (t < 0.0) ? l0 : l1);
        if (fth <= d0)
        {
            return false;
        }
    }
    
    float dist = distance(lp, pixelPosition);
	if (dist < fth)
	{
		return true;
	}
    return false;
}

vec2 rotatePosition(in vec2 pixelPosition, in vec2 offset, in float angle)
{
    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    mat2 rotationMatrix = mat2(cosAngle, -sinAngle, sinAngle, cosAngle);
	return rotationMatrix * (pixelPosition - offset);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 screenRatio = vec2(1.0, iResolution.y / iResolution.x);
    vec2 pixelPosition = ((fragCoord/iResolution.xy) * 2.0 - vec2(1.0, 1.0)) * screenRatio;
    vec3 pixelColor = vec3(1.0, 1.0, 1.0);
    if (roundedRect(rotatePosition(pixelPosition, vec2(0.0, 0.0), 0.0), vec2(0.5, 0.25), 0.25) == true)
    {
        pixelColor = vec3(1.0, 0.0, 0.0);
    }
    if (taperedRect(rotatePosition(pixelPosition, vec2(0.0, 0.3125), 0.7854), vec2(0.5, 0.25), 0.5, 1.0) == true)
    {
        pixelColor = vec3(1.0, 0.25, 0.0);
    }
	if (bluntLine(pixelPosition, vec2(-0.5, 0.0), vec2(0.5, 0.5), 2.0) == true)
    {
        pixelColor = vec3(0.0, 0.25, 1.0);
    }
    fragColor = vec4(pixelColor,1.0);
}
```



## Path tracing

```glsl
struct Ray
{
    vec3 o;
    vec3 d;
};
struct Sphere
{
    vec3 c;
    float r;
};

bool intersectSphere(in Ray ray, in Sphere sphere, out float t)
{
    vec3 oc = sphere.c - ray.o;
    float a = dot(ray.d, ray.d); 
    float b = -2.0 * dot(ray.d, oc); 
    float c = dot(oc, oc) - (sphere.r * sphere.r);
    float d = b * b - 4.0 * a * c;
    if (0.0 <= d)
    {
        float dSqrt = sqrt(d);
        float invDenom = 0.5 / a;
        float t0 = (-b + dSqrt) * invDenom;
        float t1 = (-b - dSqrt) * invDenom;
		t = min(t0, t1);
        return true;
    }
    return false;
}

const vec3 kAmbientLight = vec3(0.1, 0.1, 0.1);
const vec3 kLightDir = normalize(vec3(0, 1.0, -1.0));
void calculateLight(in vec3 n, out vec3 col)
{
    col = vec3(dot(kLightDir, n)) + kAmbientLight;
}

const mat3 kNormalizerMatrix = mat3(2.0, 0.0, 1.0, 0.0, 2.0, 0.0, -1.0, -1.0, 1.0);
const Sphere sphere = Sphere(vec3(0.0, 0.0, 5.0), 1.0);
void mainImage(out vec4 col, in vec2 pos)
{
    vec3 screenRatio = vec3(1.0, float(iResolution.x) / iResolution.y, 1.0); 
    vec3 uv = (kNormalizerMatrix * vec3(pos / iResolution.xy, 1.0)) / screenRatio;
	
    Ray ray = Ray(vec3(0.0, 0.0, -1.0), normalize(uv));
    vec3 res = vec3(abs(uv.xyx));
    float distSphere = 0.0;
    if (intersectSphere(ray, sphere, distSphere) == true)
    {
		vec3 p = ray.o + ray.d * distSphere;
		vec3 n = normalize(p - sphere.c);
		calculateLight(n, res);
    }
    
    col = vec4(res, 1);
}
```

