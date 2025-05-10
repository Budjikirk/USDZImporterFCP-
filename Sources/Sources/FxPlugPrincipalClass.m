#import "FxPlugPrincipalClass.h"
#import <SceneKit/SceneKit.h>
#import <Metal/Metal.h>

@implementation USDZImporter

- (BOOL)addParameters {
    return YES;
}

- (BOOL)frameSetup:(FxRenderInfo *)renderInfo {
    return YES;
}

- (BOOL)renderOutputImage:(FxRenderInfo *)renderInfo {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    SCNRenderer *renderer = [SCNRenderer rendererWithDevice:device options:nil];

    SCNScene *scene = [SCNScene sceneNamed:@"model.usdz"];
    if (scene == nil) {
        NSLog(@"USDZ file load failed.");
        return NO;
    }

    renderer.scene = scene;

    [renderer renderAtTime:0 viewportSize:CGSizeMake(renderInfo.width, renderInfo.height) commandBuffer:nil passDescriptor:nil];

    return YES;
}

@end
