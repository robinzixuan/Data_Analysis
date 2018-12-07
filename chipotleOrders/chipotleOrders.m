function [ out ] = chipotleOrders( file )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[num,txt,raw]=xlsread(file);
%read the file
title=raw(1,:);
raw=raw(2:end,:);
%pick out the title and detail
name=strcmp(title,'Item Name');
quality=strcmp(title,'Quantity');
cell=unique(raw(:,name));
%get the list of not same
num=cellfun(@(x)lfind(x,raw(:,name),raw(:,quality)),cell);
%find the item order times
[v,o]=max(num);
n1=cell{o};
%find the most popular one
mask1=cellfun(@(x)strcmp(x,n1),raw(:,name));
raw=raw(mask1,:);
toppings=strcmp(title,'Description');
cell1=unique(raw(:,toppings));
num1=cellfun(@(x)lfind(x,raw(:,toppings),raw(:,quality)),cell1);
[v1,o1]=max(num1);
topping=cell1{o1};
%find the most popular topping
out=sprintf('the most popular item is %s and the most popular toppings is %s',n1,topping);
%output the result
end

function [out]=lfind(cell1, cell2, cell3)
%find the exist time for each one
mask=cellfun(@(x) strcmp(x,cell1),cell2);
cell3=cell3(mask);
out= sum(cell2mat(cell3));
end