
precision mediump float;
//深度值拉长到32位储存编码
vec4 pack(float depth)
{
    // 使用rgba 4字节共32位来存储z值,1个字节精度为1/256
    const vec4 bitShift = vec4(1.0, 256.0, 256.0 * 256.0, 256.0 * 256.0 * 256.0);
    const vec4 bitMask = vec4(1.0 / 256.0, 1.0 / 256.0, 1.0 / 256.0, 0.0);
    // gl_FragCoord:片元的坐标,fract():返回数值的小数部分
    vec4 rgbaDepth = fract(depth * bitShift); //计算每个点的z值
    rgbaDepth -= rgbaDepth.gbaa * bitMask; // Cut off the value which do not fit in 8 bits
    return rgbaDepth;
}
// 计算深度值
float LinearizeDepth(float depth, float near, float far) {
  float z = depth * 2.0 - 1.0;
  return (2.0 * near * far) / (far + near - z * (far - near));
}

float near = 0.1;
float far = 1000.0;
void main() {
    // precision mediump float;
    // gl_FragColor = vec4(vec3(gl_FragCoord.z), 1.0);
    float depth = LinearizeDepth(gl_FragCoord.z, near, far) / far; // 为了演示除以 far
    gl_FragColor = vec4(vec3(depth), 1.0);
    // gl_FragColor = pack(gl_FragCoord.z);
    // gl_FragColor = vec4(vec3(0.0), 1.0);
}