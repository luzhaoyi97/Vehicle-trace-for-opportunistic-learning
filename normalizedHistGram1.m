function normalizedHistGram1(data, numBar)

[n,xout]=hist(data/10,numBar);
normalized_n=n/sum(n);
figure;
bar(xout,normalized_n);



meanV = mean(data);
theoryExp = exprnd(meanV,100000,1);
[n,xout]=hist(theoryExp,numBar);
normalized_n=n/sum(n);
hold on
%plot(xout,normalized_n,'r-','LineWidth',2);
axis([0 100 0 0.04])
%set(axis,'xtick',2:1:6)
xlabel('Off-contact time','FontSize',12);
ylabel('Stats','FontSize',13);








