const { format } = require("path");

let a = [5, 4, 7, 8, 1];
a.sort();
console.log(a);
a.splice(2, 1);
console.log(a);
a.add;
console.log(Math.min(15, 2));

var maxArea = function (height) {
  let len = height.length;
  let area = 0;
  let left = 0,
    right = len - 1;
  while (left < right) {
    tmp = (right - left) * Math.min(height[left], height[right]);
    area = Math.max(tmp, area);
    if (height[left] < height[right]) {
      left++;
    } else if (height[right] < height[left]) {
      right--;
    } else if (height[right] === height[left]) {
      left++;
      right--;
    }
  }
  return area;
};

var trap = function (height) {
  let max1 = [0],
    max2 = [0];
  for (let i = 1; i < height.length; i++) {
    max1.push(Math.max(max1[i - 1], height[i - 1]));
  }
  let j = 0;
  for (let i = height.length - 2; i >= 0; i--) {
    max2.push(Math.max(max2[j], height[i + 1]));
    j++;
  }
  max2 = max2.reverse();
  let result = [];
  for (let i = 1; i < height.length - 1; i++) {
    if (Math.min(max1[i], max2[i]) - height[i] > 0) {
      result.push(Math.min(max1[i], max2[i]) - height[i]);
    }
  }
  let sum = result.reduce((previous, current) => previous + current, 0);
  return sum;
};
console.log([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]);
console.log(trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]));
