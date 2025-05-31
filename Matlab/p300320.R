print('1__________________')
vec1 <- seq(5, 100, by = 5)
vec2 <- seq(100, 5, by = -5)
vec3 <- c(seq(2, 50, by = 2), seq(48, 2, by = -2))
vec4 <- rep(c(1, 3, 5), times = 15)
vec5 <- rep(1:4, times = c(5, 10, 15, 20))
print(vec1)
print(vec2)
print(vec3)
print(vec4)
print(vec5)



print('2__________________')
vec1_subset <- vec1[5:15]
vec2_subset <- vec2[-(1:5)]
vec3_subset <- vec3[vec3 < 40]
vec4_subset <- vec4[seq(2, length(vec4), by = 2)]
print(vec1_subset)
print(vec2_subset)
print(vec3_subset)
print(vec4_subset)



print('3__________________')
vec3_length <- length(vec3)
vec3_sum <- sum(vec3)
vec2_min <- min(vec2)
vec2_max <- max(vec2)
vec5_product <- prod(vec5)
vec1_sorted_desc <- sort(vec1, decreasing = TRUE)
print(paste("Μήκος vec3:", vec3_length))
print(paste("Άθροισμα vec3:", vec3_sum))
print(paste("Ελάχιστο vec2:", vec2_min))
print(paste("Μέγιστο vec2:", vec2_max))
print(paste("Γινόμενο vec5:", vec5_product))
print("vec1 ταξινομημένο φθίνουσα:")
print(vec1_sorted_desc)



print('4__________________')
vector_stats <- function(vec) {
  stats_list <- list(
    length = length(vec),
    min = min(vec),
    max = max(vec),
    sum = sum(vec),
    mean = mean(vec),
    sorted = sort(vec)
  )
  return(stats_list)
}
vec3 <- c(seq(2, 50, by = 2), seq(48, 2, by = -2))
result_vec3 <- vector_stats(vec3)
print(result_vec3)



print('5__________________')
x_values <- seq(0, 10, by = 0.1)
y_values <- x_values^2 * exp(-x_values)
plot(x_values, y_values, type = "l", col = "blue", lwd = 2,
     xlab = "Χ τιμές", ylab = "Τιμές της συνάρτησης",
     main = "Γράφημα της συνάρτησης x^2 * e^(-x)")
grid()



print('6__________________')
A <- matrix(c(5, 2, 1, 4, 6, 4, 3, 6, 9, 6, 5, 8, 3, 8, 7, 2), nrow = 4, byrow = TRUE)
B <- matrix(c(1, 2, 1, 4, 6, 2, 3, 6, 9, 6, 3, 8, 3, 8, 7, 4), nrow = 4, byrow = TRUE)
sum_AB <- A + B
product_AB <- A %*% B
trace_A <- sum(diag(A))
inverse_A <- solve(A)
inverse_B <- solve(B)
product_inv_AB <- inverse_A %*% inverse_B
print("Άθροισμα A + B:")
print(sum_AB)
print("Γινόμενο A * B:")
print(product_AB)
print("Άθροισμα κύριας διαγωνίου του A:")
print(trace_A)
#print("Αντίστροφος A:")
#print(inverse_A)
#print("Αντίστροφος B:")
#print(inverse_B)
print("Γινόμενο A^(-1) * B^(-1):")
print(product_inv_AB)



print('7__________________')
poisson_recursive <- function(x, lambda) {
  if (lambda <= 0) {
    stop("Η τιμή του λ πρέπει να είναι > 0")
  }

  if (x < 0) {
    stop("Η τιμή του x πρέπει να είναι >= 0")
  }

  if (x == 0) {
    return(exp(-lambda))
  }
  return(poisson_recursive( x - 1, lambda) * (lambda / x))
}
#Παράδειγμα εισόδου
lambda <- 2
x <- 3
print(paste("Poisson recursive: ", poisson_recursive(x, lambda)))
print(paste("Dpois function: ", dpois(x, lambda)))



