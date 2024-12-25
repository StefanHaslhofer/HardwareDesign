int main(void) {
    int *ptr = (int *)255;

    for (int i = 0; i <= 255; i++) {
        *ptr = i;
        
        if (i == 255) {
            i = 0;
        }
    }

    return 0;
}