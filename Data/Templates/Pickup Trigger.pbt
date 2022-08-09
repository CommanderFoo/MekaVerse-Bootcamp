Assets {
  Id: 12185415287135871786
  Name: "Pickup Trigger"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 2859771732851525319
      Objects {
        Id: 2859771732851525319
        Name: "Pickup Trigger"
        Transform {
          Scale {
            X: 2.72379947
            Y: 2.72379947
            Z: 2.72379947
          }
        }
        ParentId: 11950647702050303750
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
        Trigger {
          TeamSettings {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          TriggerShape_v2 {
            Value: "mc:etriggershape:sphere"
          }
          InteractionTemplate {
          }
          BreadcrumbTemplate {
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 118
}
