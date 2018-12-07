function [count ] = sampleanzlyze( file )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[num,cell,raw]=xlsread(file);
title=num(1,:);
mask=isnan(title);
num2=num(2:end-2,~mask);
total=num(end-1,~mask);
average=num(end,~mask);
theta_old = rand(length(title(~mask)),1);%random theta old
Y=title(~mask);
alpha=0.05;%step size
tolerance=0.01;%tolerance
maxIter=100000;%max number of iteration
[theta_new res count] = LRTheta(num2, Y, theta_old,tolerance,maxIter,alpha);
errors = abs(Y - res);%absolute difference between true labels and predicted ones
err = sum(errors);%sum errors up
percentage = 1 - err / size(num2, 1);%correct prediction rate;
subplot(1,2,1)
plot(Y,total,'r--');
subplot(1,2,2)
coff=polyfit(Y,average,length(Y)-1);
plot(Y,polyval(coff,Y),'bo:');
hold on
div=polyder(coff);
plot(Y,polyval(Y,polyval(div,Y)),'m-');
end


function [theta_new res count] = LRTheta(X, Y, theta_old,tolerance,maxIter,alpha)
    [nSamples, nFeature] = size(X);%find the sample size and number of predicted feature 
    theta_new = theta_old;
    count=0;%iteration number
    for j = 1:maxIter
        theta_old=theta_new;
        temp = zeros(nFeature,1);%matrix with zeros
        for k = 1:nFeature
            temp = temp + (1 / (1 + exp(-(X(k,:) * theta_new)))- Y(k)) * [X(k,:)]'; %model pridiction based on gradient descent
        end
       theta_new =theta_new - alpha* temp;%updata new theta
       if abs(theta_new-theta_old)<tolerance %stop if the difference between two iterations is smaller than tolerance
            break
       end
       count=count+1;
    end 
   res = zeros(nSamples,1);
   for i = 1:nSamples
       sigm = 1 / (1 + exp(-(X(i,:) * theta_new)));%predict labels based on model
       if sigm >= 0.5
            res(i) = 1; %if the value is larger than 0.5, give a label of 1; otherwise,0.
        else
            res(i) = 0;
        end
   end
end