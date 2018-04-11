%Read the dataset%
X=dlmread('simple_iris_dataset.dat');
%Number of Clusters%
K=2;
Dim=size(X);
Index=rand(1,2);
Index=Index*Dim(1,1);
Index=ceil(Index);
%Take 2 random samples from data set %
ctr1=X(Index(1),:);
ctr2=X(Index(2),:);
prevctr1=ctr1;
prevctr2=ctr2;
count=1;
while true
j=1;
m=1;
 cluster1=zeros(1,3);
 cluster2=zeros(1,3);
for i=1:100
    distance1=sqrt(((ctr1(1,1)-X(i,1))^2)+((ctr1(1,2)-X(i,2))^2));
    distance2=sqrt(((ctr2(1,1)-X(i,1))^2)+((ctr2(1,2)-X(i,2))^2));
    if distance1>distance2
        cluster2(j,:)=X(i,:);
        j=j+1;
        cluster2=[cluster2;zeros(1,3)];
    else
        cluster1(m,:)=X(i,:);
        m=m+1;
         cluster1=[cluster1;zeros(1,3)];
    end
end
cluster1=cluster1(1:size(cluster1,1)-1,:);
cluster2=cluster2(1:size(cluster2,1)-1,:);
%Compute the new centroid%
ctr1=mean(cluster1);
ctr2=mean(cluster2);
if(ctr1(1,1)==prevctr1(1,1) && ctr1(1,2)==prevctr1(1,2) && ctr2(1,1)==prevctr2(1,1) && ctr2(1,2)==prevctr2(1,2))
    break;
end
prevctr1=ctr1;
prevctr2=ctr2;
count=count+1;
end

%To plot clustered data with two different colors%
figure; 
hold on;
xlabel('Sepal Length');
ylabel('Sepal Width'); 
plot(cluster1(:,1),cluster1(:,2),'r.','MarkerSize',12)
plot(cluster2(:,1),cluster2(:,2),'b.','MarkerSize',10)
%To plot centroid of each cluster on the same plot:%
plot(ctr1(:,1),ctr1(:,2), 'kx', 'MarkerSize',12,'LineWidth',2);
plot(ctr2(:,1),ctr2(:,2), 'ko', 'MarkerSize',12,'LineWidth',2);

prediction=zeros(100,1);
cluster1label=cluster1(1,3);
cluster2label=cluster2(1,3);
for i=1:100
    distance1=sqrt(((ctr1(1,1)-X(i,1))^2)+((ctr1(1,2)-X(i,2))^2));
    distance2=sqrt(((ctr2(1,1)-X(i,1))^2)+((ctr2(1,2)-X(i,2))^2));
    if distance1>=distance2
        prediction(i,1)=cluster2label;
    else
        prediction(i,1)=cluster1label;
    end
end
% Calculate confusion matrix%
[C,order] = confusionmat(X(:,3),prediction(:,1))
%Print number of iterations required for convergence%
disp('Number of iterations required to achieve convergence :');
disp(count);
