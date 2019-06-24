/* This is free and unencumbered software released into the public domain. */

package server

import (
	"context"
	"fmt"

	"github.com/conreality/conreality-master/rpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

type ChatServer struct{}

// Ping
func (server ChatServer) Ping(ctx context.Context, req *rpc.Text) (*rpc.Text, error) {
	fmt.Printf("Ping!\n") // DEBUG
	return &rpc.Text{Message: "Pong!"}, nil
}

// Stream
func (server ChatServer) Stream(css rpc.Chat_StreamServer) error {
	return status.Errorf(codes.Unimplemented, "method Stream not implemented") // TODO
}
