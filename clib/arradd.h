
struct DataContainer {
  int id;
  float value;
  int* neighbors;
};
void addx(float *arr, int arr_length, float value);

float get_value(struct DataContainer *container);
