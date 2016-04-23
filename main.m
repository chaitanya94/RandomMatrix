function main (n)
  n = str2num(n); # Number of times the Monte-Carlo simulationis run
  uniform_count = [0 0 0 0 0]; # saddle stable-node unstable-node stable-spiral unstable-spiral
  normal_count = [0 0 0 0 0];
  exp_uniform = zeros(5, n); # To plot probability of all cases at each step
  exp_normal = zeros(5, n); # To plot probability of all cases at each step
  
  motion_x = zeros(1, n);
  motion_y = zeros(1, n);
  
  motion_x(1) = 1;
  motion_y(1) = 1;
  times = 1:1:n;
  for i = times
    #Uniform Random Variable
    [X] = getUniform();
    [M] = matrix(X(1), X(2), X(3), X(4));
    [uniform_count] = getCount(uniform_count, M(1), M(2));
    exp_uniform(:, i) = (uniform_count/n)';
    
    #Normal Random Variable
    [X] = getNormal();
    [M] = matrix(X(1), X(2), X(3), X(4));
    [normal_count] = getCount(normal_count, M(1), M(2));
    exp_normal(:, i) = (normal_count/n)';
    
    #Phase plot for molecular motion - matrix - [X1 0; 0 X4]
    
    if i != 1
      motion_x(i) = motion_x(i-1) * (X(1) + 1);
      motion_y(i) = motion_y(i-1) * (X(4) + 1);
    endif
  endfor
  
  disp("    Saddle Stable-node Unstable-node Stable-Spiral Unistable-sprial");
  disp(uniform_count/n);
  disp(normal_count/n);
  plot(motion_x, motion_y);
endfunction

function [X] = getUniform()
  X1 = rand()*2 - 1;
  X2 = rand()*2 - 1;
  X3 = rand()*2 - 1;
  X4 = rand()*2 - 1;
  
  X = [X1 X2 X3 X4];
endfunction

function [X] = getNormal()
  X1 = randn();
  X2 = randn();
  X3 = randn();
  X4 = randn();
  
  X = [X1 X2 X3 X4];
endfunction

function [retval] = matrix (X1, X2, X3, X4)
  trace = X1 + X4;
  determinant = (X1*X4) - (X2*X3);
  
  retval = [trace determinant];
endfunction


function [count] = getCount(count, t, d)
  if d < 0
    count(1) = count(1) + 1;
  elseif d > 0 && t < 0 && ((t*t) - (4*d)) < 0
    count(4) = count(4) + 1;
  elseif d > 0 && t < 0 && ((t*t) - (4*d)) > 0
    count(2) = count(2) + 1;
  elseif d > 0 && t > 0 && ((t*t) - (4*d)) < 0
    count(5) = count(5) + 1;
  elseif d > 0 && t > 0 && ((t*t) - (4*d)) > 0
    count(3) = count(3) + 1;
  endif
endfunction
