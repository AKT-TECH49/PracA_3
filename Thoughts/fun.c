#include <stdio.h>
#include <stdlib.h>

// Function to add two matrices
float** addMatrices(float **matrix1, float **matrix2, int rows, int cols) {
    // Allocate memory for the new matrix
    float **result = (float **)malloc(rows * sizeof(float *));
    for (int i = 0; i < rows; i++) {
        result[i] = (float *)malloc(cols * sizeof(float));
    }

    // Add the matrices
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[i][j] = matrix1[i][j] + matrix2[i][j];
        }
    }

    return result;
}

// Function to free the allocated memory for a matrix
void freeMatrix(float **matrix, int rows) {
    for (int i = 0; i < rows; i++) {
        free(matrix[i]);
    }
    free(matrix);
}

// Function to print a matrix
void printMatrix(float **matrix, int rows, int cols) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%f ", matrix[i][j]);
        }
        printf("\n");
    }
}

int main() {
    int rows = 2, cols = 2;

    // Allocate memory for the matrices
    float **matrix1 = (float **)malloc(rows * sizeof(float *));
    float **matrix2 = (float **)malloc(rows * sizeof(float *));
    for (int i = 0; i < rows; i++) {
        matrix1[i] = (float *)malloc(cols * sizeof(float));
        matrix2[i] = (float *)malloc(cols * sizeof(float));
    }

    // Initialize the matrices
    matrix1[0][0] = 1.0; matrix1[0][1] = 2.0;
    matrix1[1][0] = 3.0; matrix1[1][1] = 4.0;

    matrix2[0][0] = 5.0; matrix2[0][1] = 6.0;
    matrix2[1][0] = 7.0; matrix2[1][1] = 8.0;

    // Add the matrices
    float **result = addMatrices(matrix1, matrix2, rows, cols);

    // Print the result
    printf("Resultant Matrix:\n");
    printMatrix(result, rows, cols);

    // Free the allocated memory
    freeMatrix(matrix1, rows);
    freeMatrix(matrix2, rows);
    freeMatrix(result, rows);

    return 0;
}
