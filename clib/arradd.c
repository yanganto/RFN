#include "arradd.h"

void addx(float *arr, int arr_length, float value) {
  for (int i = 0; i < arr_length; ++i) {
    arr[i] += value;
  }
}


float get_value(struct DataContainer *container) {
  return container->value;
}
