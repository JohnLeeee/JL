//
//  FirstViewController.m
//  Lesson24.2-GCD
//
//  Created by lanouhn on 15/6/10.
//  Copyright (c) 2015年 John. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end
/****----GCD :
   1、采用 C 语言函数，更接近于底层，效率更高
   2、重心不在于创建子线程，而是如何让子线程完成相应的任务
   3、GCD内部为我们提供了很多内存管理， 比如为子线程添加了自动释放池。
 ****/
@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
//  串行队列
- (IBAction)chuanxingAction:(UIButton *)sender {
    //  1、获得串行队列
//         //  1.1、使用系统自带的串行队列 （不是对象不带  *   ）
//    dispatch_queue_t queue1 =  dispatch_get_main_queue() ;//  获得主队列。
    //  2、为串行队列派遣任务
    /*
         // 2.1、向串行队列里面派遣并发（或者叫异步）执行的任务
    dispatch_async( queue1 , ^{
        NSLog( @"1---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
    dispatch_async( queue1 , ^{
        NSLog( @"2---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
    dispatch_async( queue1 , ^{
        NSLog( @"3---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
     */
    
    /*
         //  2.2、向串行队列里面派遣同步执行的任务
    dispatch_sync(queue1, ^{
        NSLog( @"4---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
    dispatch_sync(queue1, ^{
        NSLog( @"5---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
    dispatch_sync(queue1, ^{
        NSLog( @"6---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
     */
    
         //  1.2、自定义串行队列
    //  参数一：队列的唯一标识，一般采用反域名。
    //  参数二：队列的类型
    dispatch_queue_t  queue2 = dispatch_queue_create( "com.wocao.www" , DISPATCH_QUEUE_SERIAL ) ;
    dispatch_async( queue2 , ^{
        NSLog( @"1---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
    dispatch_async( queue2 , ^{
        NSLog( @"2---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
    dispatch_async( queue2 , ^{
        NSLog( @"3---%@---%d---", [ NSThread currentThread ] , [[ NSThread currentThread ] isMainThread ] ) ;
    }) ;
    
    
}
//  并行队列
- (IBAction)bingxingAction:(UIButton *)sender {
    //  1、获得对应的队列
          //  1.1、获得系统为我们提供的并行队列（全局队列）
    //  参数一：队列优先级( 四个)高、默认、低、后台。一般使用默认
    //  参数二：保留参数（无符号长整形）只能写0
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0 ) ;
    /*
    //  2、为全局队列指派异步执行的任务
    dispatch_async(queue1 , ^{
        NSLog(@"***菜菜是2B， *%@, %d***", [ NSThread currentThread] , [[ NSThread currentThread ] isMainThread ] );
    }) ;
    dispatch_async(queue1 , ^{
        NSLog(@"***菜菜是SB， *%@, %d***", [ NSThread currentThread] , [[ NSThread currentThread ] isMainThread ] );
    }) ;
     */
    //  2.2、在并行队列里面指派同步执行的任务
    dispatch_sync(queue1, ^{
        NSLog(@"***菜菜是2B， *%@, %d***", [ NSThread currentThread] , [[ NSThread currentThread ] isMainThread ] );
    }) ;
    dispatch_sync(queue1, ^{
        NSLog(@"***菜菜是SB， *%@, %d***", [ NSThread currentThread] , [[ NSThread currentThread ] isMainThread ] );
    }) ;
    dispatch_sync(queue1, ^{
        NSLog(@"***菜菜是DB， *%@, %d***", [ NSThread currentThread] , [[ NSThread currentThread ] isMainThread ] );
    }) ;
    
}
/***
 并行队列在执行相应的操作的时候只能为其指派异步执行的任务，如果指派同步执行的任务，在队列中任务的执行并不能实现并发执行。
 ***/

//  单次执行
- (IBAction)danciAction:(UIButton *)sender {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //  保证这里面包住的代码只执行一次
        NSLog( @"caicaishishabi" ) ;
    });
}
//  重复执行
- (IBAction)chongfuAction:(UIButton *)sender {
    //参数一：重复执行的次数。参数二：执行队列。参数三：要执行的代码
    //  自定义并发队列。
    dispatch_queue_t  queue =  dispatch_queue_create( "com.wocao.www" , DISPATCH_QUEUE_CONCURRENT ) ;
    //  重复执行操作会将需要执行的操作重复添加到对应的队列N次。
    dispatch_apply( 10, queue, ^(size_t index) {
        NSLog(@"第%zu次caicaibiezaizhemowole" , index ) ;
    }) ;
}
//  延迟执行
- (IBAction)yanchiAction:(UIButton *)sender {
    // 参数一：延迟时间。参数二：要延迟执行的代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"esiwole" ) ;
    });
}


@end
