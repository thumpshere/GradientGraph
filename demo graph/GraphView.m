//
//  GraphView.m
//  faltuGraph
//
//  Created by Arpit Tripathi on 22/02/16.
//  Copyright © 2016 Arpit. All rights reserved.
//

#import "GraphView.h"

@interface GraphView ()
@property (strong, nonatomic) IBOutlet UIView *vwGraph;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation GraphView

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.scrollview setContentSize:CGSizeMake(600, 200)];
   
    // Do any additional setup after loading the view.
     [self createSinePoints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawCurvedLineBetweenPoints:(NSArray *)points
{
    float granularity = 100;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:points];
    
    [mutableArray insertObject:[points firstObject] atIndex:0];
    
    [mutableArray addObject:[points lastObject]];
    
    points = [NSArray arrayWithArray:mutableArray];
    
    [path moveToPoint:[self pointAtIndex:0 ofArray:points]];
    
    for (int index = 1; index < points.count - 2 ; index++) {
        
        CGPoint point0 = [self pointAtIndex:index - 1 ofArray:points];
        CGPoint point1 = [self pointAtIndex:index ofArray:points];
        CGPoint point2 = [self pointAtIndex:index + 1 ofArray:points];
        CGPoint point3 = [self pointAtIndex:index + 2 ofArray:points];
        
        for (int i = 1; i < granularity ; i++) {
            float t = (float) i * (1.0f / (float) granularity);
            float tt = t * t;
            float ttt = tt * t;
            
            CGPoint pi;
            pi.x = 0.5 * (2*point1.x+(point2.x-point0.x)*t + (2*point0.x-5*point1.x+4*point2.x-point3.x)*tt + (3*point1.x-point0.x-3*point2.x+point3.x)*ttt);
            pi.y = 0.5 * (2*point1.y+(point2.y-point0.y)*t + (2*point0.y-5*point1.y+4*point2.y-point3.y)*tt + (3*point1.y-point0.y-3*point2.y+point3.y)*ttt);
            
            if (pi.y > self.vwGraph.frame.size.height) {
                pi.y = self.vwGraph.frame.size.height;
            }
            else if (pi.y < 0){
                pi.y = 0;
            }
            
            if (pi.x > point0.x) {
                [path addLineToPoint:pi];
            }
        }
        
        [path addLineToPoint:point2];
    }
    
    
    [path addLineToPoint:[self pointAtIndex:[points count] - 1 ofArray:points]];
    
    CAShapeLayer *shapeView = [[CAShapeLayer alloc] init];
    
    shapeView.path = [path CGPath];
    
    // shapeView.strokeColor = [UIColor redColor].CGColor;
    shapeView.strokeColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientinv.png"]].CGColor;
    shapeView.fillColor = [UIColor clearColor].CGColor;
    shapeView.lineWidth = 5;
    [shapeView setLineCap:kCALineCapRound];
    
    [self.vwGraph.layer addSublayer:shapeView];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 25.0;
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
    [shapeView addAnimation:pathAnimation forKey:@"strokeEnd"];
     [self moveViewPosition:120.0f forView:self.vwGraph];
   // [self moveViewPosition:0 forView:self.vwGraph];
//   self.vwGraph =[self.vwGraph viewWithTag:100];
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options: UIViewAnimationCurveEaseOut
//                     animations:^
//     {
//         CGRect frame = self.vwGraph.frame;
//         frame.origin.y = 0;
//         frame.origin.x = (-100);
//         self.vwGraph.frame = frame;
//     }
//                     completion:^(BOOL finished)
//     {
//         NSLog(@"Completed");
//         
//     }];
//    UIView.animateWithDuration(1.0, animations: {
//        redSquare.center.x = 200.0
//    })
//    
    
}
- (void)moveViewPosition:(CGFloat)xPosition forView:(UIView *)view
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:40.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [view setFrame:CGRectMake(-1600, view.frame.origin.y,view.frame.size.width, view.frame.size.height)];
    [UIView commitAnimations];
    

      // [self resetframe];
}
-(void)resetframe{

[self.vwGraph setFrame:CGRectMake(0, self.vwGraph.frame.origin.y,self.vwGraph.frame.size.width, self.vwGraph.frame.size.height)];

    [self moveViewPosition:12.0f forView:self.vwGraph];

}
- (CGPoint)pointAtIndex:(NSUInteger)index ofArray:(NSArray *)array
{
    NSValue *value = [array objectAtIndex:index];
    
    return [value CGPointValue];
}


-(void)createSinePoints
{
    
    //    int totalWidth=300;
    //    int waveWidth=50;
    //NSMutableArray *aryPoints=[NSMutableArray new];
    
    
//    NSArray *aryWavePoint=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0, 100)],
//                           [NSValue valueWithCGPoint:CGPointMake(35, 50)],[NSValue valueWithCGPoint:CGPointMake(100, 150)],[NSValue valueWithCGPoint:CGPointMake(175, 50)],[NSValue valueWithCGPoint:CGPointMake(245, 150)],[NSValue valueWithCGPoint:CGPointMake(315, 50)], nil];
    
    NSArray *aryWavePoint=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0, 50)],
                           [NSValue valueWithCGPoint:CGPointMake(35, 35)],[NSValue valueWithCGPoint:CGPointMake(100, 152)],[NSValue valueWithCGPoint:CGPointMake(120, 35)],[NSValue valueWithCGPoint:CGPointMake(170, 110)],[NSValue valueWithCGPoint:CGPointMake(200, 50)],[NSValue valueWithCGPoint:CGPointMake(250, 150)],[NSValue valueWithCGPoint:CGPointMake(300, 75)],[NSValue valueWithCGPoint:CGPointMake(350, 175)],[NSValue valueWithCGPoint:CGPointMake(370, 110)],[NSValue valueWithCGPoint:CGPointMake(400, 50)],[NSValue valueWithCGPoint:CGPointMake(450, 150)],[NSValue valueWithCGPoint:CGPointMake(500, 75)],[NSValue valueWithCGPoint:CGPointMake(550, 175)],[NSValue valueWithCGPoint:CGPointMake(570, 110)],[NSValue valueWithCGPoint:CGPointMake(600, 50)],[NSValue valueWithCGPoint:CGPointMake(650, 150)],[NSValue valueWithCGPoint:CGPointMake(700, 75)],[NSValue valueWithCGPoint:CGPointMake(750, 175)],[NSValue valueWithCGPoint:CGPointMake(800, 110)],[NSValue valueWithCGPoint:CGPointMake(850, 110)],[NSValue valueWithCGPoint:CGPointMake(870, 110)],[NSValue valueWithCGPoint:CGPointMake(900, 50)],[NSValue valueWithCGPoint:CGPointMake(950, 150)],[NSValue valueWithCGPoint:CGPointMake(1000, 75)],[NSValue valueWithCGPoint:CGPointMake(1050, 175)],[NSValue valueWithCGPoint:CGPointMake(1070, 110)],[NSValue valueWithCGPoint:CGPointMake(1100, 75)],[NSValue valueWithCGPoint:CGPointMake(1150, 50)],[NSValue valueWithCGPoint:CGPointMake(1170, 150)],[NSValue valueWithCGPoint:CGPointMake(1200, 75)],[NSValue valueWithCGPoint:CGPointMake(1250, 175)],[NSValue valueWithCGPoint:CGPointMake(1270, 110)],[NSValue valueWithCGPoint:CGPointMake(1300, 50)],[NSValue valueWithCGPoint:CGPointMake(1350, 150)],[NSValue valueWithCGPoint:CGPointMake(1400, 75)],[NSValue valueWithCGPoint:CGPointMake(1450, 175)],[NSValue valueWithCGPoint:CGPointMake(1500, 110)],[NSValue valueWithCGPoint:CGPointMake(1550, 110)],[NSValue valueWithCGPoint:CGPointMake(1570, 110)],[NSValue valueWithCGPoint:CGPointMake(1600, 50)],[NSValue valueWithCGPoint:CGPointMake(1650, 150)],[NSValue valueWithCGPoint:CGPointMake(1700, 75)],[NSValue valueWithCGPoint:CGPointMake(1750, 175)],[NSValue valueWithCGPoint:CGPointMake(1770, 110)],[NSValue valueWithCGPoint:CGPointMake(1800, 50)],[NSValue valueWithCGPoint:CGPointMake(1850, 150)],[NSValue valueWithCGPoint:CGPointMake(1900, 75)], nil];
    
[self drawCurvedLineBetweenPoints:aryWavePoint];
    
}


@end
