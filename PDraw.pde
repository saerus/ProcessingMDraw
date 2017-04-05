class PDraw extends PVector {
  float w = 0;
  // z == -1 or 1 to up or down... 0 not modifiy
  // value of pen when is down + w !!! (to get bigger trail)
  PDraw() {
    super(0, 0, 0);
  }
  PDraw(float x, float y) {
    super(x, y, 0);
  }
  PDraw(float x, float y, float z) {
    super(x, y, z);
  }
  PDraw(float x, float y, float z, float _w) {
    super(x, y, z);
    w = _w;
  }
  PDraw(PVector p) {
    super(p.x, p.y, p.z);
  }
  PDraw(PDraw p) {
    super(p.x, p.y, p.z);
    w = p.w;
  }
}