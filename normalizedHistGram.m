function normalizedHistGram(data, numBar)

[n,xout]=hist(data,numBar);
normalized_n=n/sum(n);

handlef=figure(2);
axes1 = axes('Parent',handlef);
hhh = bar(xout,normalized_n);



meanV = mean(data);
theoryExp = exprnd(meanV,100000,1);
%theoryExp = meanV;
[n,xout]=hist(theoryExp,numBar);
normalized_n=n/sum(n);
hold on
plot(xout,normalized_n,'r-','LineWidth',2,'DisplayName','Fitting to exponential with mean of 1/i');

axis([0 1200 0 0.2])
%legend(hhh,'V2V contact duration stats');
%legend1 = legend(axes1,'show');
legend('V2V contact duration stats','Fitting with exponential distribution');

xlabel('Contact time','FontSize',12);
ylabel('Stats','FontSize',13);










