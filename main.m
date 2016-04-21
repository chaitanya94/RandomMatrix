## Copyright (C) 2016 S Chaitanya Prasad
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} main (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: S Chaitanya Prasad <chaitanya@chaitanya-Inspiron-5537>
## Created: 2016-04-21

function main (n)
  n = str2num(n); # Number of times the Monte-Carlo simulationis run
  uniform_count = [0 0 0 0 0]; # saddle stable-node unstable-node stable-spiral unstable-spiral
  normal_count = [0 0 0 0 0];
  exp_uniform = zeros(5, n); # To plot probability of all cases at each step
  exp_normal = zeros(5, n); # To plot probability of all cases at each step
  
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
  endfor
  
  disp("    Saddle Stable-node Unstable-node Stable-Spiral Unistable-sprial");
  disp(uniform_count/n);
  disp(normal_count/n);
  
  plot(times, exp_normal(2, :));
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
