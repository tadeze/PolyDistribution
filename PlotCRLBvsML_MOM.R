
CRLB = read.csv('CRLB.alpha1.csv', header = F)
MSE_ML = read.csv('MSE.ML.alpha1.csv', header = F)
MSE_MOM = read.csv('MSE.MOM.alpha1.csv', header = F)


pdf('plot.pdf', width = 8, height = 10)
par(mfrow = c(4,3))
for(i in 1:10){
  maxy = max(c(as.numeric(log(MSE_ML[i,])), as.numeric(log(MSE_MOM[i,]))))
  miny = min(log(CRLB[i,]))
  
  plot(1:10, log(CRLB[i,]), type = 'l', lty = 3, ylim = c(miny, maxy), xlab = 'alpha2', ylab = 'log(MSE)', 
       main = paste0('alpha1 = ', i))
  lines(1:10, log(CRLB[i,]), type = 'p', pch = 20);par(new = T)
  
  plot(1:10, log(MSE_ML[i,]), type = 'l', lty = 1, ylim = c(miny, maxy), xlab = '', ylab = '');
  lines(1:10, log(MSE_ML[i,]), type = 'p', pch = 17);par(new = T)
  
  plot(1:10, log(MSE_MOM[i,]), type = 'l', lty = 5, ylim = c(miny, maxy), xlab = '', ylab = '')
  lines(1:10, log(MSE_MOM[i,]), type = 'p', pch = 1)
  
  legend("topleft", c('CRLB', 'ML', 'MOM'), lty = c(3,1,5), lwd = c(1, 1, 1), pch = c(20, 17, 1), cex = .8)
}
dev.off()
