
/**
 Select gender, height, weight and age, and then read resulting BMI
 */
Slider howHigh, weight, bmiSlider, ageSlider;
//RadioButton r;
boolean male = true;
int feet = 5;
int inches = 2;
int totalInches = feet*12+inches;
int age = 15;
int w = 100;
float bmi;
CutOffPoints points;
CutOffPoints [] boysCutOffs = new CutOffPoints[19];
CutOffPoints [] girlsCutOffs = new CutOffPoints[19];
void setup() 
{
  size(700, 320);

  setupCutOffs();
  points = girlsCutOffs[15];

  howHigh = new Slider("Height", 3, 7.5, feet + inches/12.0, 20, 80, 20, 200);

  weight = new Slider("Weight", 30, 325, 100, 150, 80, 20, 200);

  ageSlider = new Slider("age", 5, 18, age, 300, 80, 20, 200);
  bmi = weight.value() * 703 / (totalInches * totalInches);
  bmiSlider = new Slider("BMI", 0, 40, bmi, 450, 80, 20, 200);


  //  r = controlP5.addRadioButton("radioButton", 20, 20);
  //  r.setItemsPerRow(2);
  //  r.setSpacingColumn(100);
  //  r.addItem("Male", 0);
  //  r.addItem("Female", 1);
  //  r.activate("Female");


  howHigh.setValueLabel(feet + "\'" + " " + inches + "\"");

  weight.setValueLabel(int(weight.value()) + " lbs");


  ageSlider.setValueLabel("" + age);
  textSize(24);
  bmi = (int(bmi*10))/10.0;
  bmiSlider.setValueLabel(bmi + " " + points.getStatus(bmi));
}

void draw() {
  background(150);
  if (male)
    points = boysCutOffs[int(ageSlider.value())];
  else
    points =  girlsCutOffs[int(ageSlider.value())];

  int high = int(points.high*200./40);
  fill(255, 0, 0);
  rect(470, 80, 220, 200-high);

  int mid =int(points.mid*200./40);
  fill(100, 100, 100);
  rect(470, 280-high, 220, high);
  int low = int(points.low*200./40);
  fill(0, 200, 0);
  rect(470, 280-mid, 220, mid);
  fill(0, 0, 255);
  rect(470, 280-low, 220, low);
  //weight.setValue(w);
  howHigh.show();
  weight.show(); 
  bmiSlider.show(); 
  ageSlider.show();
  text("Height", 10, 305);
  text("Weight", 130, 305);
  text("Age", 290, 305);
  text("BMI", 450, 305);
  if (male)
  {
    rect(5, 10, 65, 45);
    fill(0);
    text("Male", 10, 40);
    if (mouseX >= 85 && mouseX <= 175 && mouseY >= 10 && mouseY <= 55)
      fill(200);
    else
      fill(175);
    text("Female", 90, 40);
  }
  else
  {
    rect(85, 10, 90, 45);
    if (mouseX >= 5 && mouseX <= 70 && mouseY >= 10 && mouseY <= 55)
      fill(200);
    else
      fill(175);
    text("Male", 10, 40);
    fill(0);
    text("Female", 90, 40);
  }
}

//void controlEvent(ControlEvent theEvent)
//{
//
//  
//
//}
void mousePressed()
{
  if (mouseX >= 85 && mouseX <= 175 && mouseY >= 10 && mouseY <= 55)
    male = false;
  else if (mouseX >= 5 && mouseX <= 70 && mouseY >= 10 && mouseY <= 55)
    male = true;
}
void mouseDragged()
{
  if (howHigh.adjust())
  {  
    feet = int(howHigh.value());
    inches = int((howHigh.value() - int(howHigh.value()))*12);
    totalInches = feet*12+inches;
    howHigh.setValueLabel(feet + "\'" + " " + inches + "\"");
    bmi = weight.value() * 703 / (totalInches * totalInches);
    bmiSlider.setValue(bmi);
  }
  else if (weight.adjust())
  {
    bmi = weight.value() * 703 / (totalInches * totalInches);
    bmi = (int(bmi*10))/10.0;
    bmiSlider.setValue(bmi);
    weight.setValueLabel(int(weight.value()) + " lbs");
  }
  else if (bmiSlider.adjust())
  {
    bmi=bmiSlider.value();
    w = int(bmi*totalInches*totalInches/703 +.5);
    weight.setValue(w);
    weight.setValueLabel(w + " lbs");
  }
  else if (ageSlider.adjust())
  {
    if (ageSlider.value() == 18)
      ageSlider.setValueLabel("18+");
    else
      ageSlider.setValueLabel("" + int(ageSlider.value()));
  }
  bmi = (int(bmi*10))/10.0;
  bmiSlider.setValueLabel(bmi + " " + points.getStatus(bmi));
}

class CutOffPoints
{
  float low, mid, high;
  CutOffPoints(float i, float j, float k) {
    low = i;
    mid = j; 
    high = k;
  }
  String getStatus(float bmi)
  {
    if (bmi < low)
      return "Very Lean";
    else if (bmi < mid)
      return "Healthy Zone";
    else if (bmi < high)
      return "Some Risk";
    else
      return "High Risk";
  }
}
void setupCutOffs()
{
  boysCutOffs[5] = new CutOffPoints(13.9, 16.8, 17.5);
  boysCutOffs[6] = new CutOffPoints(13.8, 17.0, 17.8);
  boysCutOffs[7] = new CutOffPoints(13.8, 17.4, 18.3);
  boysCutOffs[8] = new CutOffPoints(13.9, 17.9, 19);
  boysCutOffs[9] = new CutOffPoints(14.1, 18.6, 19.9);
  boysCutOffs[10] = new CutOffPoints(14.3, 19, 20.8);
  boysCutOffs[11] = new CutOffPoints(14.6, 19.8, 21.8);
  boysCutOffs[12] = new CutOffPoints(15.1, 20.6, 22.7);
  boysCutOffs[13] = new CutOffPoints(15.5, 21.4, 23.6);
  boysCutOffs[14] = new CutOffPoints(16.1, 22.2, 24.5);
  boysCutOffs[15] = new CutOffPoints(16.6, 23.0, 25.3);
  boysCutOffs[16] = new CutOffPoints(17.2, 23.8, 26);
  boysCutOffs[17] = new CutOffPoints(17.8, 24.5, 26.7);
  boysCutOffs[18] = new CutOffPoints(18.2, 25.2, 27.5);

  girlsCutOffs[5] = new CutOffPoints(13.6, 16.8, 17.3);
  girlsCutOffs[6] = new CutOffPoints(13.5, 17.1, 17.7);
  girlsCutOffs[7] = new CutOffPoints(13.5, 17.6, 18.3);
  girlsCutOffs[8] = new CutOffPoints(13.6, 18.3, 19.1);
  girlsCutOffs[9] = new CutOffPoints(13.8, 19, 20);
  girlsCutOffs[10] = new CutOffPoints(14.1, 19.6, 21);
  girlsCutOffs[11] = new CutOffPoints(14.5, 20.5, 21.9);
  girlsCutOffs[12] = new CutOffPoints(14.9, 21.3, 22.9);
  girlsCutOffs[13] = new CutOffPoints(15.4, 22.1, 23.8);
  girlsCutOffs[14] = new CutOffPoints(15.9, 22.9, 24.6);
  girlsCutOffs[15] = new CutOffPoints(16.4, 23.6, 25.4);
  girlsCutOffs[16] = new CutOffPoints(16.9, 24.2, 26.1);
  girlsCutOffs[17] = new CutOffPoints(17.3, 24.7, 26.7);
  girlsCutOffs[18] = new CutOffPoints(17.6, 25.2, 27.2);
}
class Slider
{
  String name;
  float mn, mx, val;
  int nX, nY, nW, nH, smallRectHeight, smallRectY;
  Slider(String theName, float theMin, float theMax, 
  float theDefaultValue, int theX, int theY, int theW, int theH)
  {
    name = theName;
    mn = theMin;
    mx = theMax;
    val = theDefaultValue;
    nX = theX;
    nY = theY;
    nW = theW;
    nH = theH;
    smallRectHeight = int(nH*(val-mn)/(mx-mn));
    smallRectY = nY + nH - smallRectHeight;
  }
  void show()
  {
    fill(70);
    rect(nX, nY, nW, nH);
    if (mouseX >= nX && mouseX <= nX + nW && mouseY>=nY && mouseY <= nY + nH)
      fill(225);
    else
      fill(200);
    rect(nX, smallRectY, nW, smallRectHeight);
    text(name, nX+nW+5, smallRectY);
    fill(200);
  }
  void setValueLabel(String s)
  {
    name = s;
  }
  float value()
  {
    return val;
  }
  void setValue(float v)
  {
    val = v;
    if (val > mx )
      val = mx;
    if (val < mn)
      val = mn;
    adjust();
  }
  boolean adjust()
  {
    if (mouseX >= nX && mouseX <= nX + nW && mouseY>=nY && mouseY <= nY + nH && mousePressed)
    {
      smallRectY = mouseY;
      smallRectHeight = nY + nH - smallRectY;
    }
    else
    {
      smallRectHeight = int(nH*(val-mn)/(mx-mn));
      smallRectY = nY + nH - smallRectHeight;
    }
    val = (smallRectHeight*(mx-mn)/nH)+mn;
    if (val > mx )
      val = mx;
    if (val < mn)
      val = mn;

    if (mouseX >= nX && mouseX <= nX + nW && mouseY>=nY && mouseY <= nY + nH && mousePressed)
      return true;
    else
      return false;
  }
}


