function main
    clc; clear;
    disp('--- Gregory-Leibniz ---')
    [pi_greg, d_greg] = gregory_leibniz(1000);
    fprintf('Όροι: 1000, Προσέγγιση: %.15f, Σωστά δεκαδικά: %d\n', pi_greg, d_greg);

    disp('--- Euler ---')
    [pi_euler, d_euler] = euler_pi(10000);
    fprintf('Όροι: 10000, Προσέγγιση: %.15f, Σωστά δεκαδικά: %d\n', pi_euler, d_euler);

    disp('--- Ramanujan ---')
    [pi_raman, d_raman] = ramanujan_pi(3);
    fprintf('Όροι: 2, Προσέγγιση: %.15f, Σωστά δεκαδικά: %d\n', pi_raman, d_raman);

    disp('--- Product Series ---')
    [pi_prod, d_prod] = product_series(100);
    fprintf('Όροι: 100, Προσέγγιση: %.15f, Σωστά δεκαδικά: %d\n', pi_prod, d_prod);

    disp('--- Sqrt(3) Series ---')
    [pi_sqrt3, d_sqrt3] = sqrt3_series(100);
    fprintf('Όροι: 100, Προσέγγιση: %.15f, Σωστά δεκαδικά: %d\n', pi_sqrt3, d_sqrt3);

    disp('--- Nilakantha ---')
    [pi_nil, d_nil] = nilakantha(100);
    fprintf('Όροι: 100, Προσέγγιση: %.15f, Σωστά δεκαδικά: %d\n', pi_nil, d_nil);
end

% Οι υπόλοιπες συναρτήσεις ακολουθούν ως "local functions"
function [pi_approx, digits] = gregory_leibniz(N)
    pi_approx = 0;
    for k = 0:N-1
        pi_approx = pi_approx + ((-1)^k)/(2*k + 1);
    end
    pi_approx = 4 * pi_approx;
    digits = floor(-log10(abs(pi_approx - pi)));
end

function [pi_approx, digits] = euler_pi(N)
    sum_val = 0;
    for n = 1:N
        sum_val = sum_val + 1/n^2;
    end
    pi_approx = sqrt(6 * sum_val);
    digits = floor(-log10(abs(pi_approx - pi)));
end

function [pi_approx, digits] = ramanujan_pi(N)
    sum_val = 0;
    for n = 0:N-1
        numerator = factorial(4*n) * (1103 + 26390*n);
        denominator = (factorial(n))^4 * 396^(4*n);
        sum_val = sum_val + numerator/denominator;
    end
    pi_approx = 1 / (2*sqrt(2)/9801 * sum_val);
    digits = floor(-log10(abs(pi_approx - pi)));
end

function [pi_approx, digits] = product_series(N)
    pi_approx = 3;
    for n = 1:N
        denominator = 2*n * (2*n+1) * (2*n+2);
        term = 4 / denominator;
        if mod(n,2) == 1
            pi_approx = pi_approx + term;
        else
            pi_approx = pi_approx - term;
        end
    end
    digits = floor(-log10(abs(pi_approx - pi)));
end

function [pi_approx, digits] = sqrt3_series(N)
    sum_val = 0;
    for n = 0:N-1
        term = (-1)^n / (3^n * (2*n + 1));
        sum_val = sum_val + term;
    end
    pi_approx = 6 * sum_val / sqrt(3);
    digits = floor(-log10(abs(pi_approx - pi)));
end

function [pi_approx, digits] = nilakantha(N)
    pi_approx = 3;
    for n = 1:N
        term = 4 / ((2*n)*(2*n+1)*(2*n+2));
        if mod(n,2) == 1
            pi_approx = pi_approx + term;
        else
            pi_approx = pi_approx - term;
        end
    end
    digits = floor(-log10(abs(pi_approx - pi)));
end
