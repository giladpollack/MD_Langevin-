function [fx, fy] = computeForces(cfg, currStepData, addedData)

fx = 0;
fy = 0;
if cfg.useWalls
    if strcmp(cfg.wallRepulsionType, 'WCA')
        [fxWall, fyWall] = getWCAWallForces(currStepData.particlePositions,...
                                            cfg.R(1),...
                                            cfg.WCAEpsilon,...
                                            currStepData.wallPositionsX,...
                                            currStepData.wallPositionsY);
    else
        error(strcat('Unknown wall repulsion type ', cfg.wallRepulsionType));
    end
    fx = fx + fxWall;
    fy = fy + fyWall;
end

if cfg.useParticleRepulsion
    [fxParticles, fyParticles] = ...
        getWCAParticleForces(currStepData.particlePositions, cfg.R(1), cfg.WCAEpsilon);
    fx = fx + fxParticles;
    fy = fy + fyParticles;
end

if cfg.useTraps
    [fxTraps, fyTraps] = getTrapForces(currStepData.particlePositions, currStepData.trapPositions, cfg.A, cfg.s);
    fx = fx + fxTraps;
    fy = fy + fyTraps;
end