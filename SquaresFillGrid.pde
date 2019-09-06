import processing.pdf.*;
PImage img;

int W = int(297*2); // 2173
int H = int(450*2); // 500
int pad = 1*60;

void settings(){
	size(W+2*pad, H+2*pad);
	pixelDensity(2);
}

void setup() {
	noLoop();

	Nx = N;
	dx = 1.0*W / Nx;
	Ny = round(H / dx);
	dy = 1.0*H / Ny;
}

int N = 66;
int Nx, Ny;
float dx, dy;

void draw() {
	background(255);

	scale(2);
	beginRecord(PDF, "vector/test.pdf");
	scale(0.5);
	translate(pad, pad);

	rectMode(CENTER);
	noFill();
	stroke(0);

	dy *= 2;
	for(float y = dy/2; y < H; y += dy){
		for(float x = dx/2; x < W; x += dx){

			// float sc = map(dist(x,y,width/2,height/2), 0, dist(pad,pad,width/2,height/2), 1, 0);
			float sc = constrain(map(dist(x,y,W/2,H/2), 0, dist(0,0,W/2,H/2), 1, 0), 0, 1);
			sc = power(sc, 2);
			float w = dx*1.1;
			float h = dy*1.1;
			w += dx*3*power(noise(x*0.0001, y*0.1, 33), 2)*sc;
			h += dx*3*power(noise(x*0.0001, y*0.1, 431), 2)*sc;

			float xx = x;
			float yy = y;
			if(abs(xx - w/2) < dx*0.5) xx += -(xx-w/2);
			if(abs(yy - h/2) < dx*0.5) yy += -(yy-h/2);
			if(abs(xx + w/2) > W-dx*0.5) xx -= xx + w/2 - W;
			if(abs(yy + h/2) > H-dx*0.5) yy -= yy + h/2 - H;

			pushMatrix();
			translate(xx, yy);
			// rotate(radians(45));
			rect(0, 0, w, h);
			popMatrix();
		}
	}

	// resetMatrix();
	// stroke(255, 0, 0);
	// rect(width/2, height/2, W, H);

	endRecord();
}


float power(float p, float g) {
	if (p < 0.5)
		return 0.5 * pow(2*p, g);
	else
		return 1 - 0.5 * pow(2*(1 - p), g);
}
