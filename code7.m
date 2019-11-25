[a, b] = min(chk_error);
plot(1:100, trn_error, 'g-', 1:100, chk_error, 'r-', b, a, 'ko');
title('Training (green) and checking (red) error curve','fontsize',10);
xlabel('Epoch numbers','fontsize',10);
ylabel('RMS errors','fontsize',10);