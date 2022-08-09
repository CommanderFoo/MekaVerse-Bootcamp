Assets {
  Id: 13847419989906830265
  Name: "Mana Pickup"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 9647641322356905071
      Objects {
        Id: 9647641322356905071
        Name: "Mana Pickup"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 3873831855344145274
        ChildIds: 1431622397542462489
        ChildIds: 5846992421847466905
        UnregisteredParameters {
          Overrides {
            Name: "cs:Inventory_Pickup"
            AssetReference {
              Id: 8099296177848779074
            }
          }
          Overrides {
            Name: "cs:PickupTrigger"
            ObjectReference {
              SubObjectId: 2535931915172918886
            }
          }
          Overrides {
            Name: "cs:Item"
            ObjectReference {
              SubObjectId: 4851327974891098251
            }
          }
          Overrides {
            Name: "cs:UpDownCurve"
            SimpleCurve {
              Keys {
                Interpolation {
                  Value: "mc:erichcurveinterpmode:rcim_cubic"
                }
                TangentMode {
                  Value: "mc:erichcurvetangentmode:rctm_user"
                }
              }
              Keys {
                Interpolation {
                  Value: "mc:erichcurveinterpmode:rcim_cubic"
                }
                TangentMode {
                  Value: "mc:erichcurvetangentmode:rctm_user"
                }
                Time: 3
                Value: 1
              }
              PreExtrapolation {
                Value: "mc:erichcurveextrapolation:rcce_oscillate"
              }
              PostExtrapolation {
                Value: "mc:erichcurveextrapolation:rcce_oscillate"
              }
              DefaultValue: 3.40282347e+38
            }
          }
          Overrides {
            Name: "cs:Rotate"
            Bool: true
          }
          Overrides {
            Name: "cs:AnimateUpDown"
            Bool: true
          }
          Overrides {
            Name: "cs:multiplier"
            Float: 50
          }
          Overrides {
            Name: "cs:Outline"
            ObjectReference {
              SubObjectId: 16121938924721877974
            }
          }
          Overrides {
            Name: "cs:OutlineTrigger"
            ObjectReference {
              SubObjectId: 3216106713216064906
            }
          }
          Overrides {
            Name: "cs:Inventory_Pickup:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:Inventory_Pickup:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:PickupTrigger:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:PickupTrigger:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:Item:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:Item:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:UpDownCurve:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:UpDownCurve:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:Rotate:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:Rotate:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:AnimateUpDown:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:AnimateUpDown:ml"
            Bool: false
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Folder {
          IsGroup: true
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 3873831855344145274
        Name: "Inventory_Pickup_Default"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 9647641322356905071
        UnregisteredParameters {
          Overrides {
            Name: "cs:Root"
            ObjectReference {
              SubObjectId: 9647641322356905071
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Script {
          ScriptAsset {
            Id: 7153229304768253401
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 1431622397542462489
        Name: "Client"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 9647641322356905071
        ChildIds: 8724197670298942027
        ChildIds: 4851327974891098251
        ChildIds: 17885993417400905642
        ChildIds: 2576507809301853466
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        NetworkContext {
          MinDetailLevel {
            Value: "mc:edetaillevel:low"
          }
          MaxDetailLevel {
            Value: "mc:edetaillevel:ultra"
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 8724197670298942027
        Name: "Inventory Object Outline"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 1431622397542462489
        TemplateInstance {
          ParameterOverrideMap {
            key: 3443521175387742296
            value {
              Overrides {
                Name: "Name"
                String: "Inventory Object Outline"
              }
              Overrides {
                Name: "Position"
                Vector {
                }
              }
              Overrides {
                Name: "Rotation"
                Rotator {
                }
              }
              Overrides {
                Name: "bp:Object To Outline"
                ObjectReference {
                  SubObjectId: 4851327974891098251
                }
              }
              Overrides {
                Name: "bp:Enabled"
                Bool: false
              }
              Overrides {
                Name: "bp:Dynamic Thickness"
                Bool: false
              }
              Overrides {
                Name: "bp:Thickness"
                Float: 1
              }
            }
          }
          TemplateAsset {
            Id: 107364086786845811
          }
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 4851327974891098251
        Name: "Item"
        Transform {
          Location {
            Z: -0.168646812
          }
          Rotation {
          }
          Scale {
            X: 0.198776558
            Y: 0.198776558
            Z: 0.198776558
          }
        }
        ParentId: 1431622397542462489
        ChildIds: 10607777210800281322
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Folder {
          IsGroup: true
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 10607777210800281322
        Name: "Bottle 01"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 3.33333325
            Y: 3.33333325
            Z: 3.33333325
          }
        }
        ParentId: 4851327974891098251
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        CoreMesh {
          MeshAsset {
            Id: 9437651154019690538
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          StaticMesh {
            Physics {
              Mass: 100
              LinearDamping: 0.01
            }
            BoundsScale: 1
          }
        }
        Relevance {
          Value: "mc:eproxyrelevance:critical"
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 17885993417400905642
        Name: "Outline Trigger"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 1431622397542462489
        TemplateInstance {
          ParameterOverrideMap {
            key: 17259491069621030325
            value {
              Overrides {
                Name: "Name"
                String: "Outline Trigger"
              }
            }
          }
          TemplateAsset {
            Id: 16799078388953106667
          }
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 2576507809301853466
        Name: "Inventory_Pickup_Client"
        Transform {
          Location {
            X: -251.960754
            Y: -508.493378
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 1431622397542462489
        UnregisteredParameters {
          Overrides {
            Name: "cs:Outline"
            ObjectReference {
              SubObjectId: 16121938924721877974
            }
          }
          Overrides {
            Name: "cs:OutlineTrigger"
            ObjectReference {
              SubObjectId: 3216106713216064906
            }
          }
          Overrides {
            Name: "cs:Item"
            ObjectReference {
              SubObjectId: 4851327974891098251
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Script {
          ScriptAsset {
            Id: 16570813441883333925
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 5846992421847466905
        Name: "Pickup Trigger"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 9647641322356905071
        TemplateInstance {
          ParameterOverrideMap {
            key: 2859771732851525319
            value {
              Overrides {
                Name: "Name"
                String: "Pickup Trigger"
              }
            }
          }
          TemplateAsset {
            Id: 12185415287135871786
          }
        }
        IsReplicationEnabledByDefault: true
      }
    }
    Assets {
      Id: 9437651154019690538
      Name: "Bottle 01"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_prop_fantasy_bottle_001"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 118
  VirtualFolderPath: "Inventory System"
  VirtualFolderPath: "Item Templates"
}
