package main

func producer(c chan int) {
	for i := 0; i < 5; i++ {
		c <- i
	}
}

func consumer(c chan int) {
	for {
		i := <-c
		println(i)
	}
}

func main() {
	c := make(chan int)
	go consumer(c)
	producer(c)
}
