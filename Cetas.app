#include <iostream>
#include <math.h>
#include <vector>
using namespace std;

double Cetas(vector<double> f,double a,double b,int k);
int main(){
	double a,b;
	cout<<"Please input the range of integral:\n";
	cin>>a>>b;
	vector<double> values;

	int n;
	cout<<"Please input how many samples there are:(n must be 2^k+1)\n";
	cin>>n;
	int k=log10(n-1)/log10(2);
	if(pow(2,k)+1!=n){
		cout<<"Input is invalid!"<<endl;
		return 0;
	}

	cout<<"Times of accelebration k: "<<k<<endl;
	cout<<"Please input the values of sample:\n";
	/*
	for(int i=0;i<n;i++){
		double temp;
		cin>>temp;
		values.push_back(temp);
	}
	*/
	for(int i=0;i<5;i++){
		double x=1.0/4*i;
		values.push_back(pow(x,1.5));
	}
	double result=Cetas(values,a,b,k);
	cout<<"result: "<<result<<endl;
}
double Cetas(vector<double> f,double a,double b,int k){
	vector<double> Sum(k+1,0);
	vector<vector<double>> dp(k+1,vector<double>(3,0));
	//aim:dp[k][2]=T(k,2),浜屽垎k娆＄殑cetas绉垎鍊?
	
	//棰勫鐞?
	Sum[0]=f[0]+f.back();//f(a)+f(b)
	for(int i=1;i<=k;i++){
		Sum[i]=Sum[i-1];
		int step=(f.size()-1)/pow(2,i-1);
		for(int j=step;j<f.size();){
			Sum[i]+=f[(j+j-step)/2];
			j+=step;
		}
	}
	
	cout<<"Sum: ";
	for(int i=0;i<=k;i++){
		cout<<Sum[i]<<" ";
	}
	cout<<endl;

	
	double h=b-a;
	dp[0][0]=Sum[0]*h/2;
	cout<<dp[0][0]<<" ";
	for(int i=1;i<=k;i++){
		h=h/2;
		dp[i][0]=0.5*dp[i-1][0]+(Sum[i]-Sum[i-1])*h;//T(i,j)=0.5*T(i-1,j)+h/2*(Sum[i])
		cout<<dp[i][0]<<" ";
	}
	cout<<endl;
	for(int i=1;i<=2;i++){
		for(int j=0;j<=k-i;j++){
			double temp=pow(4,i);
			dp[j][i]=temp*dp[j+1][i-1]/(temp-1)-dp[j][i-1]/(temp-1);
			cout<<dp[j][i]<<" ";
		}
		cout<<endl;
	}

	return dp[0][2];
}
