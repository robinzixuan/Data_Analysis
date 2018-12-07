function [ cell1,cell2,cell3 ] = analyze( file )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[num,txt,cell]=xlsread(file);
title=cell(1,:);
email=strcmp(title,'email');
mask=cellfun(@isnan, cell(:,email), 'UniformOutput', false);
mask=cellfun(@all,mask);
%if there is the people have the email
cell1=cell(~mask,:);
first=strcmp(title,'first_name');
cell1=cell1(2:end,first);
%give out the cell1
hometown=strcmp(title,'hometown');
cell_home=cell(2:end,hometown);
mask2=cellfun(@(x)strfind(x,'S'),cell_home,'UniformOutput', false);
mask2=cellfun(@(x) ~isempty(x)&&(x==1),mask2)
%find the people home start s
cell2=cell(2:end,:);
IP=strcmp(title,'ip_address');
cell2=cell2(mask2,IP);
%give out the cell2
gender=strcmp(title,'gender');
mask1=cellfun(@(x)strcmp(x,'Female'),cell(:,gender));
cell3=cell(mask1,:);
%find the female
web=strcmp(title,'favorite_website');
mask3=cellfun(@(x)strfind(x,'.com'),cell3(:,web),'UniformOutput', false);
mask3=cellfun(@(x) isempty(x),mask3);
%find the web not end .com
cell3=cell3(mask3,email);
%give out the cell3
end

